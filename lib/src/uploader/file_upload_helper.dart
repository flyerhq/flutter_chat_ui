
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

typedef OnUploadProgressCallback = void Function(double percentage);

class FileService {

    FileService._();
    static final FileService _instance = FileService._();

    // ignore: sort_unnamed_constructors_first, sort_constructors_first
    factory FileService() => _instance;

    void configure({required String uploadUrl, required String token}) {
        _url = uploadUrl;
        _token = token;
    }

    String _token = '';
    String _url = '';

    static bool trustSelfSigned = true;

    static HttpClient getHttpClient() {
        final httpClient = HttpClient()
            ..connectionTimeout = const Duration(seconds: 60)
            ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);

        return httpClient;
    }

    Future<dynamic> fileUploadMultipart(
        {required String filePath, OnUploadProgressCallback? onUploadProgress}) async {

        final httpClient = getHttpClient();

        final request = await httpClient.postUrl(Uri.parse(_url));

        var byteCount = 0;

        final multipart = await http.MultipartFile.fromPath('multipartFile', filePath);

        final requestMultipart = http.MultipartRequest('POST', Uri.parse(_url));

        requestMultipart.files.add(multipart);
        requestMultipart.fields.addAll({'type':'chat'});

        final msStream = requestMultipart.finalize();

        final totalByteLength = requestMultipart.contentLength;

        request.contentLength = totalByteLength;

        var value = requestMultipart.headers['content-type'] ?? '';
        request.headers.set(HttpHeaders.contentTypeHeader, value);
        //requestMultipart.headers.addAll(headers);
        request.headers.add('Authorization', 'Bearer $_token');

        final Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
                handleData: (data, sink) {
                    sink.add(data);

                    byteCount += data.length;

                    if (onUploadProgress != null) {
                        final percentage = (byteCount * 100)/totalByteLength;
                        onUploadProgress(percentage);
                        // CALL STATUS CALLBACK;
                    }
                },
                handleError: (error, stack, sink) {
                    throw error;
                },
                handleDone: (sink) {
                    sink.close();
                    // UPLOAD DONE;
                },
            ),
        );

        await request.addStream(streamUpload);

        final httpResponse = await request.close();
//
        final statusCode = httpResponse.statusCode;

        if (statusCode ~/ 100 != 2) {
            throw Exception('Error uploading file, Status code: ${httpResponse.statusCode}');
        } else {
            final response = await readResponseAsString(httpResponse);
            final jsonObject = json.decode(response);
            return jsonObject;
        }
    }

    static Future<String> readResponseAsString(HttpClientResponse response) {
        final completer = Completer<String>();
        final contents = StringBuffer();
        response.transform(utf8.decoder).listen((String data) {
            contents.write(data);
        }, onDone: () => completer.complete(contents.toString()));
        return completer.future;
    }

}
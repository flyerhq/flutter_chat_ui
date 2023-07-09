import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import 'api.dart';
import 'api_get_initial_messages.dart';
import 'gemini.dart';
import 'initialize/initialize.dart';
import 'local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await initialize();
  runApp(FlyerChat(database: database));
}

class FlyerChat extends StatelessWidget {
  final Database database;

  const FlyerChat({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flyer Chat',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      home: FlyerChatHomePage(database: database),
    );
  }
}

class FlyerChatHomePage extends StatefulWidget {
  final Database database;

  const FlyerChatHomePage({super.key, required this.database});

  @override
  State<FlyerChatHomePage> createState() => _FlyerChatHomePageState();
}

class _FlyerChatHomePageState extends State<FlyerChatHomePage> {
  final _dio = Dio();
  String senderId = 'sender1';

  @override
  void dispose() {
    super.dispose();
    _dio.close(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'sender1',
                  label: Text('sender1'),
                ),
                ButtonSegment<String>(
                  value: 'sender2',
                  label: Text('sender2'),
                ),
              ],
              selected: <String>{senderId},
              onSelectionChanged: (Set<String> newSender) {
                setState(() {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  senderId = newSender.first;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  getInitialMessages(_dio).then((messages) {
                    if (mounted && context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Api(
                            userId: senderId,
                            initialMessages: messages,
                            dio: _dio,
                          ),
                        ),
                      );
                    }
                  }).catchError((error) {
                    debugPrint('Error: $error');
                  });
                },
                child: const Text('api'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Local(userId: senderId, dio: _dio),
                    ),
                  );
                },
                child: const Text('local'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Gemini(database: widget.database),
                    ),
                  );
                },
                child: const Text('gemini'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api.dart';
import 'api_get_chat_id.dart';
import 'api_get_initial_messages.dart';
import 'basic.dart';
import 'gemini.dart';
import 'local.dart';
import 'pagination.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await dotenv.load();
  await Hive.initFlutter();
  await Hive.openBox('chat');
  runApp(FlyerChat());
}

class FlyerChat extends StatelessWidget {
  const FlyerChat({super.key});

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
      home: const FlyerChatHomePage(),
    );
  }
}

class FlyerChatHomePage extends StatefulWidget {
  const FlyerChatHomePage({super.key});

  @override
  State<FlyerChatHomePage> createState() => _FlyerChatHomePageState();
}

class _FlyerChatHomePageState extends State<FlyerChatHomePage> {
  final _dio = Dio();

  final _chatIdController = TextEditingController(
    text: dotenv.env['DEFAULT_CHAT_ID'] ?? '',
  );
  final _geminiApiKeyController = TextEditingController(
    text: dotenv.env['GEMINI_API_KEY'] ?? '',
  );

  UserID _currentUserId = 'john';

  @override
  void dispose() {
    _geminiApiKeyController.dispose();
    _chatIdController.dispose();
    _dio.close(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              SegmentedButton<UserID>(
                segments: const <ButtonSegment<UserID>>[
                  ButtonSegment<UserID>(value: 'john', label: Text('John')),
                  ButtonSegment<UserID>(value: 'jane', label: Text('Jane')),
                ],
                selected: <UserID>{_currentUserId},
                onSelectionChanged: (Set<UserID> newSender) {
                  setState(() {
                    _currentUserId = newSender.first;
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _chatIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'chat id',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getInitialMessages(_dio, chatId: _chatIdController.text)
                          .then((messages) {
                            if (mounted && context.mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Api(
                                    currentUserId: _currentUserId,
                                    chatId: _chatIdController.text,
                                    initialMessages: messages,
                                    dio: _dio,
                                  ),
                                ),
                              );
                            }
                          })
                          .catchError((error) {
                            if (mounted && context.mounted) {
                              debugPrint(error.toString());
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                      'Make sure the chat ID is correct',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                    },
                    child: const Text('api'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text(
                              'Are you sure you want to generate a new chat ID?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  getChatId(_dio).then((chatId) {
                                    if (mounted) {
                                      _chatIdController.text = chatId;
                                    }
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('generate chat id'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: _chatIdController.text),
                      );
                    },
                    child: const Text('copy chat id'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'In order to test the api, you need to generate a chat id. Chat will be reset after 24 hours. Use the same chat id to access chat on different devices.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Local(dio: _dio)),
                  );
                },
                child: const Text('local'),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _geminiApiKeyController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'gemini api key',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Gemini(geminiApiKey: _geminiApiKeyController.text),
                    ),
                  );
                },
                child: const Text('gemini'),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'In order to test the AI example, you need to provide your own Gemini API key',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Pagination()));
                },
                child: const Text('pagination'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Basic()));
                },
                child: const Text('basic'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

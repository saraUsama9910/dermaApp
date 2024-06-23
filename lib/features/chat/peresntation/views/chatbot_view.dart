import 'package:flutter/material.dart';
import 'package:graduation/features/chat/peresntation/widgets/chat_bot_body.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatBotBody();
  }
}
/*
MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 87, 183)),
        useMaterial3: true,
      ),
      home: const ChatBotBody(),
    )
 */

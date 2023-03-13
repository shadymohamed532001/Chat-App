import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholor_chat/Screans/ChatScrean.dart';
import 'package:scholor_chat/Screans/LoginScrean.dart';
import 'package:scholor_chat/Screans/RegisterScrean.dart';
import 'package:scholor_chat/constans.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        KLoginScreen: (context) => const LoginScrean(),
        KRegisterScrean: (context) => const RegisterScrean(),
        KChatScrean: (context) =>  ChatScrean()


      },
      debugShowCheckedModeBanner: false,
      home: const LoginScrean(),
    );
  }
}

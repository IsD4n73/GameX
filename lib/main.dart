import 'package:RAWG_dart_wrapper/controller/rawg.dart';
import 'package:flutter/material.dart';
import 'package:gamex/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Rawg(apiKey: "ff98fccb8e2e4f249d657a82a2d4ac60");
    return MaterialApp(
      title: 'GameX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff212129)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

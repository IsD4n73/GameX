import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gamex/view/home.dart';
import 'package:rawg_dart_wrapper/rawg_dart_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Rawg(apiKey: "ff98fccb8e2e4f249d657a82a2d4ac60");
    return MaterialApp(
      title: 'GameX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff212129)),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white, 
          displayColor: Colors.white, 
        ), 
      ),
      builder: EasyLoading.init(),
      home: const HomePage(),
    );
  }
}

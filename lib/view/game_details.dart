import 'package:flutter/material.dart';
import 'package:RAWG_dart_wrapper/RAWG_dart_wrapper.dart';

class GameDetailsPage extends StatefulWidget {
  final Game game;
  const GameDetailsPage(this.game, {super.key});

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
} 


class _GameDetailsPageState extends State<GameDetailsPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212129),
      appBar: AppBar(
        backgroundColor: const Color(0xff212129),
        title: Text(
          "GameX - ${widget.game.name}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ), 
      body: const Placeholder(),
    );
  }
}

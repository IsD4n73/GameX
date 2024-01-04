import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gamex/view/tabs/widget/card_adaptive.dart';
import 'package:gamex/view/tabs/widget/carousel_image.dart';
import 'package:rawg_dart_wrapper/rawg_dart_wrapper.dart';

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
          widget.game.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CarouselImage(),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              HtmlWidget(
                widget.game.description,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardAdaptive("Released: ${widget.game.released}"),
                  const SizedBox(width: 5),
                  CardAdaptive(
                      "Achievements: ${widget.game.achievementsCount}"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardAdaptive("Original Name: ${widget.game.nameOriginal}"),
                  const SizedBox(width: 5),
                  CardAdaptive(
                      "Alternative Names: ${widget.game.alternativeNames.isEmpty ? "None" : widget.game.alternativeNames.join(",")}"),
                ],
              ),
              const SizedBox(height: 10),
              CardAdaptive("Website: ${widget.game.website}"),
            ],
          ),
        ),
      ),
    );
  }
}

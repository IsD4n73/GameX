import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> screen;
  const CarouselImage(this.screen, {super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.screen.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.network(
                        i,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text("❌"),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.screen.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 4,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(
                  _current == entry.key ? 0.9 : 0.4,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

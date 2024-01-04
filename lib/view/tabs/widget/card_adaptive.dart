import 'package:flutter/material.dart';

class CardAdaptive extends StatelessWidget {
  final String text;
  const CardAdaptive(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: text.contains("Website:") ? double.infinity : 160,
      height: 75,
      decoration: const BoxDecoration(
        color: Color(0xff32323e),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

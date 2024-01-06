import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CardAdaptive extends StatelessWidget {
  final String text;
  final bool shimmer;
  final void Function()? onTap;
  const CardAdaptive(this.text, {super.key, this.onTap, this.shimmer = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20), 
      child: Container(
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
).animate(onPlay: (controller) => controller.repeat())
 .shimmer(duration: 1200.ms, color: shimmer ? const Color(0xFF80DDFF) : Colors.transparent)
 .animate() 
);
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardAdaptive extends StatelessWidget {
  final String text;
  final bool? shimmer;
  final void Function()? onTap;
  const CardAdaptive(this.text, {super.key, this.onTap, this.shimmer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20), 
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: shimmer ?? false,
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
      ),),
    );
  }
}

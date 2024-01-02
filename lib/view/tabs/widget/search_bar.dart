import 'package:flutter/material.dart';

class SearchBarCustom extends StatelessWidget {
  final void Function()? clear;
  final void Function()? search;
  final TextEditingController searchController;
  const SearchBarCustom(
      {super.key,
      required this.clear,
      required this.search,
      required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Color(0xff212129),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.clear,
                      ),
                      onPressed: clear)
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: search,
              child: const Icon(
                Icons.search,
                color: Color(0xff212129),
              ),
            ),
          )
        ],
      ),
    );
  }
}

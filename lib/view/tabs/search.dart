import 'package:RAWG_dart_wrapper/RAWG_dart_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gamex/view/tabs/widget/search_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();

  final PagingController<int, Game> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      if (searchController.text.isNotEmpty && searchController.text != "") {
        try {
          _pagingController.appendPage(
              await Rawg.getGames(page: pageKey, query: searchController.text),
              ++pageKey);
        } on RawgException catch (e) {
          _pagingController.error = e.cause;
        }
      } else {
        _pagingController.itemList = [];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarCustom(
          clear: () => setState(() {
            searchController.clear();
          }),
          search: () async {
            try {
              if (searchController.text.isNotEmpty &&
                  searchController.text != "") {
                _pagingController.itemList =
                    await Rawg.getGames(page: 1, query: searchController.text);
              } else {
                _pagingController.itemList = [];
              }
            } on RawgException catch (e) {
              _pagingController.error = e.cause;
            }
            setState(() {});
          },
          searchController: searchController,
        ),
        Flexible(
          child: PagedGridView<int, Game>(
            pagingController: _pagingController,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            showNewPageProgressIndicatorAsGridChild: false,
            builderDelegate: PagedChildBuilderDelegate<Game>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => InkWell(
                onTap: () {},
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: CircleAvatar(
                          radius: 50,
                          foregroundImage: NetworkImage(item.backgroundImage),
                          backgroundColor: const Color(0xff212129),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${item.name} ${item.tba ? "(TBA)" : ""}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rawg_dart_wrapper/rawg_dart_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gamex/view/tabs/widget/search_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../game_details.dart';

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
              noItemsFoundIndicatorBuilder: (_) => Center(child: Text("No items found", style: TextStyle(color: Colors.white),),),
              noMoreItemsIndicatorBuilder: (_) => Center(child: Text("No more items found", style: TextStyle(color: Colors.white),),),
              itemBuilder: (context, item, index) => InkWell(
                onTap: () async {
                  EasyLoading.show(status: 'loading...');
                  Game game = await Rawg.getGameDetails(id: item.id);

                  if (!context.mounted) {
                    EasyLoading.showError('Failed to load game',
                        duration: const Duration(seconds: 3));
                    return;
                  }

                  EasyLoading.dismiss();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameDetailsPage(game),
                    ),
                  );
                },
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

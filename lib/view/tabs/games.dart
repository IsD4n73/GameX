import 'package:gamex/view/game_details.dart';
import 'package:rawg_dart_wrapper/rawg_dart_wrapper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GamesTab extends StatefulWidget {
  const GamesTab({super.key});

  @override
  State<GamesTab> createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  final PagingController<int, Game> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        _pagingController.appendPage(
            await Rawg.getGames(page: pageKey), ++pageKey);
      } on RawgException catch (e) {
        _pagingController.error = e.cause;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Game>(
      pagingController: _pagingController,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      showNewPageProgressIndicatorAsGridChild: false,
      builderDelegate: PagedChildBuilderDelegate<Game>(
        animateTransitions: true,
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
              children: [
                CircleAvatar(
                  radius: 60,
                  foregroundImage: NetworkImage(item.backgroundImage),
                  backgroundColor: const Color(0xff212129),
                  child: const CircularProgressIndicator(),
                ),
                Text(
                  "${item.name} ${item.tba ? "(TBA)" : ""}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

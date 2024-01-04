import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rawg_dart_wrapper/rawg_dart_wrapper.dart';

class GenreTab extends StatefulWidget {
  const GenreTab({super.key});

  @override
  State<GenreTab> createState() => _GenreTabState();
}

class _GenreTabState extends State<GenreTab> {
  final PagingController<int, Genre> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        _pagingController.appendLastPage(await Rawg.getGenres());
      } on RawgException catch (e) {
        _pagingController.error = e.cause;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Genre>(
      pagingController: _pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<Genre>(
        animateTransitions: true,
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            tileColor: Colors.white,
            title: Text(item.name),
            subtitle: Text("Games: ${item.gamesCount}"),
            trailing: CircleAvatar(
              foregroundImage: NetworkImage(item.imageBackground),
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

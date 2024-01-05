import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rawg_dart_wrapper/rawg_dart_wrapper.dart';

class PlatformTab extends StatefulWidget {
  const PlatformTab({super.key});

  @override
  State<PlatformTab> createState() => _PlatformTabState();
}

class _PlatformTabState extends State<PlatformTab> {
  final PagingController<int, Platform> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        _pagingController.appendLastPage(await Rawg.getPlatforms());
      } on RawgException catch (e) {
        _pagingController.error = e.cause;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Platform>(
      pagingController: _pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<Platform>(
        animateTransitions: true, 
        noItemsFoundIndicatorBuilder: (_) => Center(child: Text("No items found", style: TextStyle(color: Colors.white),),),
        noMoreItemsIndicatorBuilder: (_) => Center(child: Text("No more items found", style: TextStyle(color: Colors.white),),),
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            tileColor: Colors.white,
            title: Text(item.name),
            subtitle: Text("Games: ${item.gamesCount}"),
            trailing: CircleAvatar(
              foregroundImage: NetworkImage(
                  item.image != "" ? item.image : item.imageBackground),
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

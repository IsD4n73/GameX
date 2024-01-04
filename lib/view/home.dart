import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gamex/view/tabs/games.dart';
import 'package:gamex/view/tabs/genre.dart';
import 'package:gamex/view/tabs/platform.dart';
import 'package:gamex/view/tabs/search.dart';
import 'package:gamex/view/tabs/widget/error.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget switchTabs(int index) {
    switch (index) {
      case 0:
        return const GamesTab();
      case 1:
        return const SearchTab();
      case 2:
        return const PlatformTab();
      case 3:
        return const GenreTab();
      default:
        return const ErrorTab();
    }
  }

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212129),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff212129),
        title: const Text(
          "GameX",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        elevation: 5,
        backgroundColor: const Color(0xff212129),
        items: const [
          TabItem(icon: Icons.gamepad, title: 'Games'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.videogame_asset, title: 'Platform'),
          TabItem(icon: Icons.type_specimen, title: 'Genre'),
          //TabItem(icon: Icons.emoji_events, title: 'Trophies'),
        ],
        onTap: (int i) => setState(() {
          selectedTab = i;
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: switchTabs(selectedTab),
      ),
    );
  }
}

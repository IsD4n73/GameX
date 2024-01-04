import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gamex/view/tabs/widget/card_adaptive.dart';
import 'package:gamex/view/tabs/widget/carousel_image.dart';
import 'package:rawg_dart_wrapper/controller/rawg.dart';
import 'package:rawg_dart_wrapper/models/achievement.dart';
import 'package:rawg_dart_wrapper/models/game.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailsPage extends StatefulWidget {
  final Game game;
  const GameDetailsPage(this.game, {super.key});

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  List<String> screen = [];
  final _controllerNames = SuperTooltipController();
  final _controllerPlatform = SuperTooltipController();

  @override
  void initState() {
    Rawg.getScreenshot(gameID: widget.game.id).then((value) {
      setState(() {
        screen = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212129),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff212129),
        title: Text(
          widget.game.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              screen.isNotEmpty
                  ? CarouselImage(screen)
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              HtmlWidget(
                widget.game.description,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardAdaptive("Released: ${widget.game.released}"),
                  const SizedBox(width: 5),
                  CardAdaptive(
                    "Achievements: ${widget.game.achievementsCount}",
                    onTap: () async {
                      EasyLoading.show(status: 'loading...');
                      List<Achievement> achievement =
                          await Rawg.getAchievements(id: widget.game.id);

                      if (!context.mounted || achievement.isEmpty) {
                        EasyLoading.showError("Cannot load achievements",
                            duration: const Duration(seconds: 3));
                        return;
                      }

                      EasyLoading.dismiss();
                      showStickyFlexibleBottomSheet(
                        minHeight: 0,
                        initHeight: 0.5,
                        maxHeight: 1,
                        maxHeaderHeight: 10,
                        context: context,
                        bottomSheetBorderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        isModal: true,
                        bottomSheetColor: const Color(0xff212129),
                        headerBuilder: (BuildContext context, double offset) {
                          return Container(
                            color: const Color(0xff212129),
                          );
                        },
                        bodyBuilder: (context, bottomSheetOffset) {
                          return SliverChildListDelegate(
                            [
                              ListView.builder(
                                itemCount: achievement.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      achievement[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      achievement[index].description,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    trailing: Text(
                                      "${achievement[index].percent}%",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    leading:
                                        Image.network(achievement[index].image),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        anchors: [0, 0.5, 1],
                        isSafeArea: true,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardAdaptive("Original Name: ${widget.game.nameOriginal}"),
                  const SizedBox(width: 5),
                  SuperTooltip(
                    controller: _controllerNames,
                    borderRadius: 20,
                    hideTooltipOnTap: true,
                    showBarrier: false,
                    hasShadow: false,
                    content: Text(
                        "Alternative Names: ${widget.game.alternativeNames.isEmpty ? "None" : widget.game.alternativeNames.join(",")}"),
                    child: CardAdaptive(
                      "Alternative Names: ${widget.game.alternativeNames.isEmpty ? "None" : widget.game.alternativeNames.join(",")}",
                      onTap: () {
                        _controllerNames.showTooltip();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardAdaptive("Play Time: ${widget.game.playtime}h"),
                  const SizedBox(width: 5),
                  SuperTooltip(
                    controller: _controllerPlatform,
                    borderRadius: 20,
                    hideTooltipOnTap: true,
                    showBarrier: false,
                    hasShadow: false,
                    content: Text(
                        "Platforms: ${widget.game.platforms.isEmpty ? "None" : widget.game.platforms.map((e) => "${e.name} ").toString().replaceAll("(", "").replaceAll(")", "")}"),
                    child: CardAdaptive(
                      "Platforms: ${widget.game.platforms.isEmpty ? "None" : widget.game.platforms.map((e) => "${e.name} ").toString().replaceAll("(", "").replaceAll(")", "")}",
                      onTap: () {
                        _controllerPlatform.showTooltip();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CardAdaptive(
                "Website: ${widget.game.website}",
                onTap: () async {
                  if (widget.game.website != "" &&
                      !await launchUrl(Uri.parse(widget.game.website))) {
                    EasyLoading.showError("Cannot open url",
                        duration: const Duration(seconds: 3));
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

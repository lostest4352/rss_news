import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';
import 'package:that_app/notifiers/tile_notifier.dart';
import 'package:that_app/views/widgets/appdrawer.dart';
import 'package:that_app/views/news_content_page.dart';
import 'package:that_app/views/widgets/cached_image.dart';

class OfflineArticlesPage extends StatelessWidget {
  const OfflineArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Articles"),
      ),
      drawer: const AppDrawer(),
      body: Consumer<List<SavedArticle>?>(
        builder: (context, articlesList, child) {
          if (articlesList == null || articlesList.isEmpty) {
            return const Center(
              child: Text("No articles saved"),
            );
          }

          debugPrint("rebuilt above column");

          final TileNotifier tileNotifier =
              TileNotifier(articlesList: articlesList);

          return ListenableBuilder(
            listenable: tileNotifier,
            builder: (context, child) {
              return Column(
                children: [
                  () {
                    debugPrint("rebuilt below column");
                    if (tileNotifier.tileValues.contains(true)) {
                      final listContainingTrue =
                          tileNotifier.tileValues.where((element) {
                        return element == true;
                      });
                      return Container(
                        padding: const EdgeInsets.only(left: 12, top: 8),
                        height: 40,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Delete ${listContainingTrue.length} items?",
                                ),
                                const Spacer(),
                                const Text("Select All"),
                                const SizedBox(
                                  width: 3,
                                ),
                                Checkbox(
                                  value: () {
                                    if (tileNotifier.tileValues
                                        .contains(false)) {
                                      return false;
                                    } else {
                                      return true;
                                    }
                                  }(),
                                  onChanged: (_) {
                                    if (tileNotifier.tileValues
                                        .contains(false)) {
                                      tileNotifier.addAllArticles();
                                    } else {
                                      tileNotifier.removeAllArticles();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                TextButton(
                                  onPressed: () {
                                    showAdaptiveDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            child: Column(
                                              // mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Spacer(),
                                                Text(
                                                  "Do you really want to delete ${listContainingTrue.length} items?",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        // Delete items
                                                        for (final savedArticle
                                                            in tileNotifier
                                                                .selectedSavedArticles) {
                                                          context
                                                              .read<
                                                                  AppDatabase>()
                                                              .deleteArticle(
                                                                savedArticle.id,
                                                              );
                                                        }

                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }(),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 5,
                        );
                      },
                      itemCount: articlesList.length,
                      itemBuilder: (context, index) {
                        return SelectableRegion(
                          focusNode: FocusNode(),
                          selectionControls: DesktopTextSelectionControls(),
                          child: InkWell(
                            onLongPress: () {
                              tileNotifier.changeValues(index);
                            },
                            onTap: () {
                              if (tileNotifier.tileValues.contains(true)) {
                                tileNotifier.changeValues(index);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return NewsContentPage(
                                        newsClass:
                                            articlesList[index].newsClass,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              color: (tileNotifier.tileValues[index] == false)
                                  ? Colors.black45
                                  : Colors.blueGrey[800],
                              child: Column(
                                children: [
                                  ListTile(
                                    selected: tileNotifier.tileValues[index],
                                    leading: SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: Builder(
                                        builder: (context) {
                                          //
                                          final xmlImageLink =
                                              articlesList[index]
                                                  .newsClass
                                                  .xmlImageLink;
                                          //
                                          final htmlImageLink =
                                              articlesList[index]
                                                  .newsClass
                                                  .htmlImageLink;
                                          if (xmlImageLink != null) {
                                            return CachedImage(
                                                imageLink: xmlImageLink);
                                          } else if (xmlImageLink == null &&
                                              htmlImageLink != null) {
                                            return CachedImage(
                                                imageLink: htmlImageLink);
                                          } else {
                                            return const SizedBox(
                                              child: CircleAvatar(
                                                child: Icon(Icons.newspaper),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    title: Text(
                                        articlesList[index].newsClass.title),
                                    subtitle: Builder(
                                      builder: (context) {
                                        if (articlesList[index]
                                                .newsClass
                                                .description !=
                                            null) {
                                          return Text(
                                            articlesList[index]
                                                .newsClass
                                                .description!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

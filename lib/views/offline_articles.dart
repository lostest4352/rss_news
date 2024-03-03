import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';
import 'package:that_app/notifiers/tile_notifier.dart';
import 'package:that_app/views/appdrawer.dart';
import 'package:that_app/views/news_content_page.dart';

class OfflineArticlesPage extends StatelessWidget {
  const OfflineArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Articles"),
      ),
      drawer: const AppDrawer(),
      body: MultiProvider(
          providers: [
            ChangeNotifierProxyProvider<List<SavedArticle>?, TileNotifier>(
              create: (context) {
                return TileNotifier();
              },
              update: (context, articlesList, tileNotifier) {
                return tileNotifier!
                  ..articlesList = articlesList
                  ..insertTileVals();
              },
            ),
          ],
          builder: (context, child) {
            return Consumer2<List<SavedArticle>?, TileNotifier>(
              builder: (context, articlesList, tileNotifier, child) {
                if (articlesList == null || articlesList.isEmpty) {
                  return const Center(
                    child: Text("No articles saved"),
                  );
                }

                debugPrint("Rebuilt above column");

                return Column(
                  children: [
                    () {
                      debugPrint("Rebuilt below column");
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
                                                                  savedArticle
                                                                      .id,
                                                                );
                                                          }

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
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
                                              return CachedNetworkImage(
                                                imageUrl: xmlImageLink,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const Icon(
                                                      Icons.error);
                                                },
                                              );
                                            } else if (xmlImageLink == null &&
                                                htmlImageLink != null) {
                                              return CachedNetworkImage(
                                                imageUrl: htmlImageLink,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const Icon(
                                                      Icons.error);
                                                },
                                              );
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
          }),
    );
  }
}

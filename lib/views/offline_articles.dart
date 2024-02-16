import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';
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
      body: Consumer<List<SavedArticle>?>(
        builder: (context, classList, child) {
          if (classList == null || classList.isEmpty) {
            return const Center(
              child: Text("No articles saved"),
            );
          }

          List<SavedArticle> selectedSavedArticles = [];

          ValueNotifier<List<bool>> tileValues =
              ValueNotifier(List.filled(classList.length, false));

          return ListenableBuilder(
            listenable: tileValues,
            builder: (context, child) {
              return Column(
                children: [
                  () {
                    if (tileValues.value.contains(true)) {
                      final listContainingTrue =
                          tileValues.value.where((element) {
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
                                    if (tileValues.value.contains(false)) {
                                      return false;
                                    } else {
                                      return true;
                                    }
                                  }(),
                                  onChanged: (value) {
                                    if ((tileValues.value.contains(false))) {
                                      tileValues.value =
                                          List.filled(classList.length, true);
                                      // Add all
                                      selectedSavedArticles.addAll(classList);
                                    } else {
                                      tileValues.value =
                                          List.filled(classList.length, false);
                                      // Remove all
                                      selectedSavedArticles = [];
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
                                                            in selectedSavedArticles) {
                                                          context
                                                              .read<
                                                                  AppDatabase>()
                                                              .deleteArticle(
                                                                  savedArticle
                                                                      .id);
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
                      itemCount: classList.length,
                      itemBuilder: (context, index) {
                        return SelectableRegion(
                          focusNode: FocusNode(),
                          selectionControls: DesktopTextSelectionControls(),
                          child: InkWell(
                            onLongPress: () {
                              tileValues.value[index] =
                                  !tileValues.value[index];
                              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                              tileValues.notifyListeners();

                              // Add or remove item
                              if (selectedSavedArticles
                                  .contains(classList[index])) {
                                return;
                              } else {
                                if (tileValues.value[index] == true) {
                                  selectedSavedArticles.add(classList[index]);
                                } else {
                                  selectedSavedArticles
                                      .remove(classList[index]);
                                }
                              }
                            },
                            onTap: () {
                              if (tileValues.value.contains(true)) {
                                tileValues.value[index] =
                                    !tileValues.value[index];
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                tileValues.notifyListeners();

                                // Add or remove item
                                if (selectedSavedArticles
                                    .contains(classList[index])) {
                                  return;
                                } else {
                                  if (tileValues.value[index] == true) {
                                    selectedSavedArticles.add(classList[index]);
                                  } else {
                                    selectedSavedArticles
                                        .remove(classList[index]);
                                  }
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return NewsContentPage(
                                        newsClass: classList[index].newsClass,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              color: (tileValues.value[index] == false)
                                  ? Colors.black45
                                  : Colors.blueGrey[900],
                              child: Column(
                                children: [
                                  ListTile(
                                    selected: tileValues.value[index],
                                    title:
                                        Text(classList[index].newsClass.title),
                                    subtitle: Builder(
                                      builder: (context) {
                                        if (classList[index]
                                                .newsClass
                                                .description !=
                                            null) {
                                          return Text(
                                            classList[index]
                                                .newsClass
                                                .description!,
                                            maxLines: 4,
                                          );
                                        } else {
                                          return const Center();
                                        }
                                      },
                                    ),
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(
                                      builder: (context) {
                                        final xmlImageLink = classList[index]
                                            .newsClass
                                            .xmlImageLink;
                                        if (xmlImageLink != null) {
                                          return CachedNetworkImage(
                                            imageUrl: xmlImageLink,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) {
                                              return const Icon(Icons.error);
                                            },
                                          );
                                        } else {
                                          return const Center();
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(
                                      builder: (context) {
                                        final htmlImageLink = classList[index]
                                            .newsClass
                                            .htmlImageLink;
                                        if (htmlImageLink != null) {
                                          return CachedNetworkImage(
                                            imageUrl: htmlImageLink,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) {
                                              return const Icon(Icons.error);
                                            },
                                          );
                                        } else {
                                          return const Center();
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

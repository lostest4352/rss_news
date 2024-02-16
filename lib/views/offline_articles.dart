import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';
import 'package:that_app/views/appdrawer.dart';
import 'package:that_app/views/news_content_page.dart';

class OfflineArticlesPage extends StatelessWidget {
  const OfflineArticlesPage({super.key});

  // bool boolVal = false;
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

          ValueNotifier<List<bool>> tileValues =
              ValueNotifier(List.filled(classList.length, false));

          return ListenableBuilder(
              listenable: tileValues,
              builder: (context, child) {
                return Column(
                  children: [
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
                                // boolVal = !boolVal;
                                // setState(() {});
                                tileValues.value[index] =
                                    !tileValues.value[index];
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                tileValues.notifyListeners();

                                debugPrint(tileValues.value.toString());
                              },
                              onTap: () {
                                if (tileValues.value.contains(true)) {
                                  tileValues.value[index] =
                                      !tileValues.value[index];
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  tileValues.notifyListeners();
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
                                      title: Text(
                                          classList[index].newsClass.title),
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
                                              errorWidget:
                                                  (context, url, error) {
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
                                              errorWidget:
                                                  (context, url, error) {
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
              });
        },
      ),
    );
  }
}

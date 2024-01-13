import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:that_app/models/news_class.dart';
import 'package:xml/xml.dart';

class GetFeed with ChangeNotifier {
  // final List<String> listVal = [];

  // final List<String> listImg = [];

  // TODO
  final List<NewsClass> newsClassList = [];

  final xmlUrl =
      Uri.parse("https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml");

  void getData() async {
    final response = await http.get(xmlUrl);

    if (response.statusCode == 200) {
      final xmlValue = XmlDocument.parse(response.body);

      final itemListFromXml = xmlValue.findAllElements("item");

      for (final listElement in itemListFromXml.toList()) {
        // TODO Title
        final title =
            listElement.findElements("title").single.innerText.removeTags();

        // listVal.add(title);
        // debugPrint(fixedTitle.toString());

        // TODO  Image inside media:content
        final getMediaEl = listElement.findElements("media:content");
        final String? innerImageLink = getMediaEl.firstOrNull?.getAttribute("url").toString().removeTags();
        // if (imagesVal != null) {
        //   final newVal = imagesVal.removeTags();
        //   // debugPrint(imagesVal);
        //   // listImg.add(newVal);
        // }

        //  TODO link
        final String imageLink = listElement
            .findElements("link")
            .single
            .innerText
            .removeTags(); // TODO remove removetax if issue happen

        // TODO description
        final String description = listElement
            .findElements("description")
            .single
            .innerText
            .removeTags();

        // TODO pubDate
        final String pubDate =
            listElement.findElements("pubDate").single.innerText;

        // TODO content
        // final String content =
        //     listElement.findElements("content").single.innerText;

        // TODO print

        // debugPrint(title);

        //
        final NewsClass newsClass = NewsClass(
          title: title,
          link: imageLink,
          description: description,
          pubDate: pubDate,
          content: null,
          imageLink: imageLink,
          innerImageLink: innerImageLink,
        );
        newsClassList.add(newsClass);
        

        notifyListeners(); // Important
      }

      // debugPrint(xmlValue.toString());
    } else {
      debugPrint(response.body);
    }
  }
}

// String htmlEntityDecode(String input) {
//   final text = input.replaceAllMapped(RegExp(r'&#(\d+);'),
//       (match) => String.fromCharCode(int.parse(match.group(1)!)));
//   return text.replaceAllMapped(RegExp(r'&#x([0-9A-Fa-f]+);'),
//       (match) => String.fromCharCode(int.parse(match.group(1)!, radix: 16)));
// }

extension XmlHelper on String {
  // RegExp(r'<title>|<\/title>')
  // String removeRegexTags({required String regexElement}) {
  //   String outputString = replaceAll(RegExp(regexElement), '');

  //   String output =
  //       utf8.decode(latin1.encode(HtmlUnescape().convert(outputString)));
  //   return output;
  // }

  String removeTags() {
    final convertedText =
        utf8.decode(latin1.encode(HtmlUnescape().convert(this)));
    return convertedText;
  }
}

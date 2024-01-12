import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:that_app/global_vars/regex_values.dart';
import 'package:that_app/models/news_class.dart';
import 'package:xml/xml.dart';

class GetFeed with ChangeNotifier {
  final List<String> listVal = [];

  final List<String> listImg = [];

  // TODO
  final List<NewsClass> newsClassList = [];

  final xmlUrl =
      Uri.parse("https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml");

  void getData() async {
    final response = await http.get(xmlUrl);

    if (response.statusCode == 200) {
      final xmlValue = XmlDocument.parse(response.body);

      final elements = xmlValue.findAllElements("item");

      for (final elem in elements.toList()) {
        // TODO Title
        final title = elem.getElement("title");
        final fixedTitle =
            title.toString().removeTags(regexElement: titleRegex);
        listVal.add(fixedTitle.toString());
        // debugPrint(fixedTitle.toString());

        // TODO Image
        final getMediaEl = elem.findElements("media:content");
        final imagesVal = getMediaEl.first.getAttribute("url");
        if (imagesVal != null) {
          // debugPrint(imagesVal);
          listImg.add(imagesVal);
        }

        //  TODO link
        final link = elem.getElement("link");
        final fixedLink = link.toString().removeTags(regexElement: linkRegex);

        // TODO description
        final description = elem.getElement("description");
        final fixedDescription =
            description.toString().removeTags(regexElement: descriptionRegex);

        // TODO pubDate
        final pubDate = elem.getElement("pubDate");
        final fixedPubDate =
            pubDate.toString().removeTags(regexElement: pubDateRegex);

        // TODO print
        debugPrint(fixedPubDate);

        //
        // final NewsClass newsClass = NewsClass(
        //   title: output,
        //   link: link,
        //   description: description,
        //   pubDate: pubDate,
        //   content: content,
        //   imageLink: imageLink,
        //   imageContent: imageContent,
        // );

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

// TODO extension if needed

extension XmlHelper on String {
  // RegExp(r'<title>|<\/title>')
  String removeTags({required String regexElement}) {
    String outputString = replaceAll(RegExp(regexElement), '');

    String output =
        utf8.decode(latin1.encode(HtmlUnescape().convert(outputString)));
    return output;
  }
}

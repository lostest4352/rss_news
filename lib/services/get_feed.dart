import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:that_app/models/news_class.dart';
import 'package:xml/xml.dart';

class GetFeed with ChangeNotifier {
  final List<String> listVal = [];

  final HtmlUnescape htmlUnescape = HtmlUnescape();

  final xmlUrl =
      Uri.parse("https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml");

  void getData() async {
    final response = await http.get(xmlUrl);

    if (response.statusCode == 200) {
      final xmlValue = XmlDocument.parse(response.body);

      final elements = xmlValue.findAllElements("item");

      for (final elem in elements.toList()) {
        final values = elem.findElements("title");

        // Only one title inside "item". So first works. toString() without first returns items inside brackets
        final val = values.first.toString();
        String outputString = val.replaceAll(RegExp(r'<title>|<\/title>'), '');

        String output =
            utf8.decode(latin1.encode(htmlUnescape.convert(outputString)));
        listVal.add(output);
        notifyListeners();

        debugPrint(output);

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



// TODO
extension StringXML on String {
  String convertTitle() {
    final replaceTagsString = replaceAll(RegExp(r'<title>|<\/title>'), '');
    final decodedTitle =
        utf8.decode(latin1.encode(HtmlUnescape().convert(replaceTagsString)));
    return decodedTitle;
  }

  String convertLink() {
    final replaceTagsString = replaceAll(RegExp(r'<link>|<\/link>'), '');
    // final decodedTitle =
    //     utf8.decode(latin1.encode(HtmlUnescape().convert(replaceTagsString)));
    return replaceTagsString;
  }

  String convertDescription() {
    final replaceTagsString = replaceAll(RegExp(r'<description>|<\/description>'), '');
    final decodedTitle =
        utf8.decode(latin1.encode(HtmlUnescape().convert(replaceTagsString)));
    return decodedTitle;
  }

  String convertPubDate() {
    final replaceTagsString = replaceAll(RegExp(r'<pubDate>|<\/pubDate>'), '');
    // final decodedTitle =
    //     utf8.decode(latin1.encode(HtmlUnescape().convert(replaceTagsString)));
    return replaceTagsString;
  }

  // TODO
  String convertContent() {
    final replaceTagsString = replaceAll(RegExp(r'<content:encoded>|<\/content:encoded>'), '');
    final decodedTitle =
        utf8.decode(latin1.encode(HtmlUnescape().convert(replaceTagsString)));
    return decodedTitle;
  }

  // TODO Image link and ImageSource

  
}

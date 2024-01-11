import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
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
            utf8.decode(latin1.encode(htmlEntityDecode(outputString)));
        listVal.add(output);
        notifyListeners();

        debugPrint(output);
      }

      // debugPrint(xmlValue.toString());
    } else {
      debugPrint(response.body);
    }
  }
}

String htmlEntityDecode(String input) {
  final text = input.replaceAllMapped(RegExp(r'&#(\d+);'),
      (match) => String.fromCharCode(int.parse(match.group(1)!)));
  return text.replaceAllMapped(RegExp(r'&#x([0-9A-Fa-f]+);'),
      (match) => String.fromCharCode(int.parse(match.group(1)!, radix: 16)));
}

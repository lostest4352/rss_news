import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:that_app/models/news_class.dart';
import 'package:xml/xml.dart';
import 'package:html/parser.dart' show parse;

class GetFeed with ChangeNotifier {
  final List<NewsClass> newsClassList = [];

  void getData(String newsUrl) async {
    //
    newsClassList.clear();
    final xmlUrl = Uri.parse(newsUrl);
    final response = await http.get(xmlUrl);

    if (response.statusCode == 200) {
      final xmlValue = XmlDocument.parse(response.body);

      final itemListFromXml = xmlValue.findAllElements("item");

      for (final listElement in itemListFromXml.toList()) {
        // Title
        final title =
            listElement.findElements("title").first.innerText.removeTags();

        // Image inside media:content
        final getMediaXmlElement = listElement.findElements("media:content");
        final String? xmlImageLink = getMediaXmlElement.firstOrNull
            ?.getAttribute("url")
            .toString()
            .removeTags();

        // Link
        final String? siteLink = listElement
            .findElements("link")
            .firstOrNull
            ?.innerText
            .removeTags();

        // description old
        // final String description = listElement
        //     .findElements("description")
        //     .single
        //     .innerText
        //     .removeTags();

        // description function. some descriptions were just text but some were inside html so used a function and inside try catch
        String descriptionFunc() {
          final String description =
              listElement.findElements("description").first.innerText;

          try {
            final htmltext = parse(description);

            final text = htmltext.body?.text;
            // debugPrint(text);
            return text ?? "";
          } catch (e) {
            debugPrint("not parsed");
            return description;
          }
        }

        final String description = descriptionFunc().removeTags().trim();

        // pubDate
        final String? pubDate =
            listElement.findElements("pubDate").firstOrNull?.innerText;

        // dc creator
        final String? creatorName = listElement
            .findElements("dc:creator")
            .firstOrNull
            ?.innerText
            .removeTags()
            .trim();

        // debugPrint(creatorName);

        // News content and Image src link from html inside of xml
        (String?, String?) contentElementsFunc() {
          try {
            final innerTextVal = listElement
                .findElements("content:encoded")
                .firstOrNull
                ?.innerText;

            // Inner text is html
            final htmlDoc = parse(innerTextVal);

            // For content inside <p> tags
            final paragraphTagsList = htmlDoc.getElementsByTagName("p");
            final joinedName = paragraphTagsList
                .fold("", (previousValue, element) {
                  return "$previousValue\n\n${element.text}";
                })
                .removeTags()
                .trim();

            // For images
            final imageTags = htmlDoc.getElementsByTagName("img");
            final imageFromTags = imageTags.firstOrNull?.attributes["src"];

            return (joinedName, imageFromTags);
          } catch (e) {
            return (null, null);
          }
        }

        final contentElements = contentElementsFunc();

        //
        final NewsClass newsClass = NewsClass(
          title: title,
          link: siteLink,
          description: description,
          pubDate: pubDate,
          content: contentElements.$1,
          htmlImageLink: contentElements.$2,
          xmlImageLink: xmlImageLink,
          creator: creatorName,
        );
        newsClassList.add(newsClass);
        notifyListeners();
      }
    } else {
      debugPrint(response.body);
    }
  }
}

extension XmlHelper on String {
  // latin1 encode and utf8 decode fails to return nepali language code but it is necessary for some english rss like new york times. So used try catch
  String removeTags() {
    final convertedText = HtmlUnescape().convert(this);
    try {
      String output = utf8.decode(
        latin1.encode(convertedText),
      );
      return output;
    } catch (e) {
      return convertedText;
    }
  }
}

// Saved 3
  // String removeTags() {
  //   final convertedText = HtmlUnescape().convert(this);
  //   // debugPrint("before $convertedText");
  //   final decodedText =
  //       convertedText.replaceAll(RegExp(r'â|â|â|â|â'), "'");
  //   // debugPrint("after $decodedText");

  //   return decodedText;
  // }

// Saved 2
// Regex inside extension
// RegExp(r'<title>|<\/title>')
// String removeRegexTags({required String regexElement}) {
//   String outputString = replaceAll(RegExp(regexElement), '');

//   String output =
//       utf8.decode(latin1.encode(HtmlUnescape().convert(outputString)));
//   return output;
// }

// Saved 1
// Regex to parse xml
// String htmlEntityDecode(String input) {
//   final text = input.replaceAllMapped(RegExp(r'&#(\d+);'),
//       (match) => String.fromCharCode(int.parse(match.group(1)!)));
//   return text.replaceAllMapped(RegExp(r'&#x([0-9A-Fa-f]+);'),
//       (match) => String.fromCharCode(int.parse(match.group(1)!, radix: 16)));
// }

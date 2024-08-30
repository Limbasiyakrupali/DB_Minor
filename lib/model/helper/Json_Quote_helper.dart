// import 'dart:convert';
//
// import 'package:flutter/services.dart';
//
// import '../jsonmodel.dart';
//
// class JsonQuoteHelper {
//   JsonQuoteHelper._();
//
//   static final JsonQuoteHelper jsonQuoteHelper = JsonQuoteHelper._();
//
//   Future<List<Jsonmodel>> fetchJSONData() async {
//     String rowData = await rootBundle.loadString("assets/alldata.json");
//     List data = jsonDecode(rowData);
//
//     List<Jsonmodel> mainData = [];
//
//     data.map((category) {
//       List<Jsonmodel> quotes = (category['quotes'] as List).map((quote) {
//         return Jsonmodel.fromMap(data: quote);
//       }).toList();
//       mainData.addAll(quotes);
//     }).toList();
//
//     return mainData;
//   }
//
//   Future<List<Jsonquotecatagory>> fetchCategories() async {
//     String rowData = await rootBundle.loadString("assets/alldata.json");
//     List data = jsonDecode(rowData);
//
//     List<Jsonquotecatagory> categoryNames =
//         data.map((e) => Jsonquotecatagory.fromMap(data: e)).toList();
//
//     return categoryNames;
//   }
// }
import 'dart:convert';

import 'package:flutter/services.dart';

import '../jsonmodel.dart';

class JsonQuoteHelper {
  JsonQuoteHelper._();

  static final JsonQuoteHelper jsonQuoteHelper = JsonQuoteHelper._();

  Future<List<Jsonmodel>> fetchJSONData() async {
    String rowData = await rootBundle.loadString("assets/alldata.json");
    List data = jsonDecode(rowData);

    List<Jsonmodel> mainData = [];

    data.map((category) {
      List<Jsonmodel> quotes = (category['quotes'] as List).map((quote) {
        return Jsonmodel.fromMap(data: quote);
      }).toList();
      mainData.addAll(quotes);
    }).toList();

    return mainData;
  }

  Future<List<Jsonquotecatagory>> fetchCategories() async {
    String rowData = await rootBundle.loadString("assets/alldata.json");
    List data = jsonDecode(rowData);

    List<Jsonquotecatagory> categoryNames =
        data.map((e) => Jsonquotecatagory.fromMap(data: e)).toList();

    return categoryNames;
  }

  Future<List<Jsonmodel>> fetchQuotesByCategory(String categoryName) async {
    String rowData = await rootBundle.loadString("assets/alldata.json");
    List data = jsonDecode(rowData);

    // Find the category and its quotes
    final category = data.firstWhere(
      (cat) => cat['name'] == categoryName,
      orElse: () => null,
    );

    if (category != null) {
      List<Jsonmodel> quotes = (category['quotes'] as List).map((quote) {
        return Jsonmodel.fromMap(data: quote);
      }).toList();
      return quotes;
    } else {
      return [];
    }
  }
}

import 'package:db_minor/views/Quote_detail_page.dart';
import 'package:db_minor/views/detailpage.dart';
import 'package:db_minor/views/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => Homepage(),
      'detail': (context) => DeatailPage(),
      'quote_detail': (context) => Quotedetailpage(),
    },
  ));
}

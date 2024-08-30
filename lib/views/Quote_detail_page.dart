import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

import '../model/jsonmodel.dart';
import '../provider/favourite_provider.dart';

class Quotedetailpage extends StatefulWidget {
  const Quotedetailpage({super.key});

  @override
  State<Quotedetailpage> createState() => _QuotedetailpageState();
}

class _QuotedetailpageState extends State<Quotedetailpage> {
  Color selFontColor = Colors.black;
  GlobalKey repaintKey = GlobalKey();

  Future<void> shareImage() async {
    RenderRepaintBoundary renderRepaintBoundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    Uint8List fetchImage = byteData!.buffer.asUint8List();

    Directory directory = await getApplicationDocumentsDirectory();

    File file = File('${directory.path}/quote_image.png');
    await file.writeAsBytes(fetchImage);

    ShareExtend.share(file.path, "image");
  }

  @override
  Widget build(BuildContext context) {
    final Jsonmodel quote =
        ModalRoute.of(context)!.settings.arguments as Jsonmodel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quote Detail",
          style: GoogleFonts.getFont("Mulish",
              textStyle: const TextStyle(fontSize: 21)),
        ),
        centerTitle: true,
      ),
      body: RepaintBoundary(
        key: repaintKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 271,
              width: 300,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://static.vecteezy.com/system/resources/thumbnails/037/982/950/small_2x/ai-generated-world-peace-day-dove-brings-hope-and-harmony-photo.jpeg"),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    blurStyle: BlurStyle.solid,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quote.quote,
                      style: GoogleFonts.getFont("Mulish",
                          textStyle:
                              TextStyle(fontSize: 18, color: selFontColor)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "- ${quote.author}",
                        style: GoogleFonts.getFont("Mulish",
                            textStyle:
                                TextStyle(fontSize: 16, color: selFontColor)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await FlutterClipboard.copy(quote.quote);
                          },
                          icon: const Icon(Icons.copy, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () async {
                            await shareImage();
                          },
                          icon: const Icon(Icons.share, color: Colors.black),
                        ),
                        Consumer<FavouriteProvider>(
                          builder: (context, favProvider, child) {
                            bool isLiked = favProvider.isLiked(quote);
                            return IconButton(
                              onPressed: () {
                                if (isLiked) {
                                  favProvider.disLike(model: quote);
                                } else {
                                  favProvider.like(model: quote);
                                }
                              },
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Change Font Color",
                style: GoogleFonts.getFont("Mulish",
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Row(
                  children: Colors.accents.map((color) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selFontColor = color;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black87, width: 3),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

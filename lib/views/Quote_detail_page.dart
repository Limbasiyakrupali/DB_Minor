import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class Quotedetailpage extends StatefulWidget {
  const Quotedetailpage({super.key});

  @override
  State<Quotedetailpage> createState() => _QuotedetailpageState();
}

class _QuotedetailpageState extends State<Quotedetailpage> {
  Color selFontColor = Colors.black;
  String? selImage;

  GlobalKey repaintKey = GlobalKey();

  get images => null;
  Future<void> shareImage() async {
    RenderRepaintBoundary renderRepaintBoundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    Uint8List fetchImage = byteData!.buffer.asUint8List();

    Directory directory = await getApplicationCacheDirectory();

    String path = directory.path;

    File file = File('$path.png');

    file.writeAsBytes(fetchImage);

    ShareExtend.share(file.path, "Image");
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Page",
          style: GoogleFonts.getFont("Mulish",
              textStyle: TextStyle(
                fontSize: 21,
              )),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 271,
                    width: 300,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 5.0,
                            blurStyle: BlurStyle.solid,
                          ),
                        ],
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://static.vecteezy.com/system/resources/thumbnails/037/982/950/small_2x/ai-generated-world-peace-day-dove-brings-hope-and-harmony-photo.jpeg"),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${data['quote']}",
                            style: GoogleFonts.getFont("Mulish",
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: selFontColor,
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "- ${data['author']}",
                              style: GoogleFonts.getFont("Mulish",
                                  textStyle: TextStyle(
                                      fontSize: 16, color: selFontColor)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await FlutterClipboard.copy(data['quote'])
                                      .then((value) {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     backgroundColor: Colors.grey,
                                    //     behavior: SnackBarBehavior.floating,
                                    //     content: Text(
                                    //       "Copied Success!!!",
                                    //       style: TextStyle(color: Colors.black),
                                    //     ),
                                    //   ),
                                    // );
                                  });
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    await shareImage();
                                  },
                                  icon: Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Change Font Color",
                  style: GoogleFonts.getFont("Mulish",
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
              child: Row(
                children: Colors.accents
                    .map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selFontColor = e;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: e,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black87,
                                width: 3,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

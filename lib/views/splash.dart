import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 30), () {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Card(
                  elevation: 4,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://play-lh.googleusercontent.com/R8pZoeUkAsZJFTBaLTylfx5BKbCUHmM-sDFX1Tr8Clq3PapuGFdnRo1pCYq-NhkTGQ=w240-h480-rw"))),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Quotes",
                  style: GoogleFonts.getFont(
                    "Mulish",
                    textStyle: const TextStyle(fontSize: 35),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

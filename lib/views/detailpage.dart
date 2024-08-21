import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeatailPage extends StatefulWidget {
  const DeatailPage({super.key});

  @override
  State<DeatailPage> createState() => _DeatailPageState();
}

class _DeatailPageState extends State<DeatailPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List quotes = data['quotes'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${data['name']} Quotes",
          style: GoogleFonts.getFont(
            "Mulish",
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed("quote_detail", arguments: quotes[index]);
              },
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Colors.yellow.shade100
                        : Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quotes[index]['quote'],
                        style: GoogleFonts.getFont(
                          "Mulish",
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "- ${quotes[index]['author']}",
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

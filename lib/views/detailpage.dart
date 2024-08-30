import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/helper/Json_Quote_helper.dart';
import '../model/jsonmodel.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<Jsonmodel>> futureQuotes;
  late String selectedCategoryName;

  @override
  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context)?.settings.arguments as Jsonquotecatagory?;
    selectedCategoryName = category?.categoryName ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$selectedCategoryName Quotes",
          style: GoogleFonts.getFont(
            "Mulish",
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Jsonmodel>>(
        future: JsonQuoteHelper.jsonQuoteHelper
            .fetchQuotesByCategory(selectedCategoryName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Jsonmodel>? quotes = snapshot.data;
            return (quotes == null || quotes.isEmpty)
                ? const Center(child: Text("No quotes available"))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      final quote = quotes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("quote_detail", arguments: quote);
                          },
                          child: Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.teal.shade50
                                    : Colors.teal.shade100.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    quote.quote,
                                    style: GoogleFonts.getFont(
                                      "Mulish",
                                      textStyle: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "- ${quote.author}",
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
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

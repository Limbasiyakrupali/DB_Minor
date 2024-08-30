import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/helper/database.dart';
import '../model/jsonmodel.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favourite Quotes",
          style: GoogleFonts.getFont(
            "Mulish",
            textStyle: const TextStyle(fontSize: 22),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("DELETE"),
                    content: const Text(
                        "Are you sure you want to delete all favorite quotes?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await DbHelper.dbHelper.removeAllDB();
                          setState(() {}); // Refresh the list after deletion
                          Navigator.of(context).pop();
                        },
                        child: const Text('Delete'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<List<Jsonmodel>>(
        future: DbHelper.dbHelper.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Jsonmodel>? data = snapshot.data;

            if (data == null || data.isEmpty) {
              return Center(
                child: Text(
                  "No favorite quotes available",
                  style: GoogleFonts.getFont(
                    "Mulish",
                    textStyle:
                        const TextStyle(fontSize: 18, color: Colors.black38),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: 110,
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.teal.shade50
                            : Colors.teal.shade100.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text(
                          data[index].quote.toString(),
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "~ ${data[index].author.toString()}",
                            style: GoogleFonts.getFont(
                              "Mulish",
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

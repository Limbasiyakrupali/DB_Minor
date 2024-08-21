import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<String> jsondata;

  loaddata() {
    jsondata = rootBundle.loadString("assets/alldata.json");
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quote App",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                            border: OutlineInputBorder()),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 15,
              child: FutureBuilder(
                future: jsondata,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR: ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    String? data = snapshot.data;

                    List allposts = (data == null) ? [] : jsonDecode(data);

                    return (data == null)
                        ? const Center(
                            child: Text("No data found"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("detail",
                                      arguments: allposts[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? Colors.yellow.shade100
                                                : Colors.pink.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${allposts[index]['name']}",
                                                style: GoogleFonts.getFont(
                                                    "Mulish",
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                allposts.length, // Use the length of allposts
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ))
        ],
      ),
    );
  }
}

import 'package:db_minor/model/helper/Json_Quote_helper.dart';
import 'package:db_minor/model/helper/database.dart';
import 'package:db_minor/model/jsonmodel.dart';
import 'package:db_minor/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quote App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal.shade100.withOpacity(0.8),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("fav");
              },
              icon: Icon(
                Icons.favorite,
                size: 29,
                color: Colors.black,
              )),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).Changetheme();
            },
            icon: Icon(
              Icons.dark_mode,
              size: 30,
              color: Provider.of<ThemeProvider>(
                context,
              ).istapped
                  ? Colors.white70
                  : Colors.black,
            ),
          ),
        ],
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
                        onChanged: (val) {
                          DbHelper.dbHelper.searchCategory(data: val);
                        },
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
              flex: 14,
              child: FutureBuilder<List<Jsonquotecatagory>>(
                future: JsonQuoteHelper.jsonQuoteHelper.fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR: ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Jsonquotecatagory>? data = snapshot.data;

                    return (data == null || data.isEmpty)
                        ? const Center(
                            child: Text("No data found"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    "detail",
                                    arguments: data[index],
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Card(
                                    elevation: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? Colors.teal.shade50
                                                : Colors.teal.shade100
                                                    .withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${data[index].categoryName}",
                                                style: GoogleFonts.getFont(
                                                  "Mulish",
                                                  textStyle: const TextStyle(
                                                      fontSize: 20),
                                                ),
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
                            itemCount: data.length,
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

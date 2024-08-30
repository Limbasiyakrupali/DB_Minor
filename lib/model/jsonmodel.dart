class Jsonmodel {
  int id;
  String quote;
  String author;

  Jsonmodel({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Jsonmodel.fromMap({required Map<String, dynamic> data}) {
    return Jsonmodel(
      id: data['id'],
      quote: data['quote'],
      author: data['author'],
    );
  }
}

class Jsonquotecatagory {
  String categoryName;

  Jsonquotecatagory({required this.categoryName});

  factory Jsonquotecatagory.fromMap({required Map<String, dynamic> data}) {
    return Jsonquotecatagory(
      categoryName: data['name'],
    );
  }
}

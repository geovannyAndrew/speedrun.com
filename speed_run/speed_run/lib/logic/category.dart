
class Category{

  final String id;
  final String name;
  final String weblink;
  final String type;
  final String rules;

  Category(
      this.id,
      this.name,
      this.weblink,
      this.type,
      this.rules
      );

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(json['id'].toString(),
        json['name'].toString(),
        json["weblink"].toString(),
        json["type"].toString(),
        json["rules"].toString()
    );
  }
}
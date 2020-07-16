
class AttributeName {
  AttributeName({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory AttributeName.fromJson(Map<String, dynamic> json) => AttributeName(
    id: json["id"],
    name: json["name"],
  );


}




class AttributeTerm {
  AttributeTerm({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory AttributeTerm.fromJson(Map<String, dynamic> json) => AttributeTerm(
    id: json["id"],
    name: json["name"],
  );


}


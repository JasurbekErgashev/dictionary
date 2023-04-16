import 'dart:convert';

Definition fromJson(String str) => Definition.fromMap(json.decode(str));

String toJson(Definition data) => json.encode(data.toMap());

class Definition {
  int id;
  String word;
  String type;
  String description;
  int idAlphabet;

  Definition({
    required this.id,
    required this.word,
    required this.type,
    required this.description,
    required this.idAlphabet,
  });

  factory Definition.fromMap(Map<String, dynamic> json) => Definition(
        id: json["ID"],
        word: json["Word"],
        type: json["Type"],
        description: json["Description"],
        idAlphabet: json["ID_ALPHABET"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "Word": word,
        "Type": type,
        "Description": description,
        "ID_ALPHABET": idAlphabet,
      };
}

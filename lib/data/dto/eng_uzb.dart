import 'dart:convert';

EngUzb fromJson(String str) => EngUzb.fromMap(json.decode(str));

String toJson(EngUzb data) => json.encode(data.toMap());

class EngUzb {
  int id;
  String eng;
  String pron;
  String uzb;
  int isFav;
  int isHistory;

  EngUzb({
    required this.id,
    required this.eng,
    required this.pron,
    required this.uzb,
    required this.isFav,
    required this.isHistory,
  });

  factory EngUzb.fromMap(Map<String, dynamic> json) => EngUzb(
        id: json["_id"],
        eng: json["eng"],
        pron: json["pron"],
        uzb: json["uzb"],
        isFav: json["isFav"],
        isHistory: json["isHistory"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "eng": eng,
        "pron": pron,
        "uzb": uzb,
        "isFav": isFav,
        "isHistory": isHistory,
      };
}

import 'dart:convert';

EngUzb fromJson(String str) => EngUzb.fromMap(json.decode(str));

String toJson(EngUzb data) => json.encode(data.toMap());

class EngUzb {
  String eng;
  String pron;
  String uzb;
  int isFav;
  int isHistory;

  EngUzb({
    required this.eng,
    required this.pron,
    required this.uzb,
    required this.isFav,
    required this.isHistory,
  });

  factory EngUzb.fromMap(Map<String, dynamic> json) => EngUzb(
        eng: json["eng"],
        pron: json["pron"],
        uzb: json["uzb"],
        isFav: json["isFav"],
        isHistory: json["isHistory"],
      );

  Map<String, dynamic> toMap() => {
        "eng": eng,
        "pron": pron,
        "uzb": uzb,
        "isFav": isFav,
        "isHistory": isHistory,
      };
}

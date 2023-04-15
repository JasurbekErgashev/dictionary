import 'dart:convert';

UzbEng fromJson(String str) => UzbEng.fromMap(json.decode(str));

String toJson(UzbEng data) => json.encode(data.toMap());

class UzbEng {
  int id;
  String uzb;
  String eng;
  String? eng1;
  String? eng2;
  int isFav;
  int isHistory;

  UzbEng({
    required this.id,
    required this.uzb,
    required this.eng,
    required this.eng1,
    required this.eng2,
    required this.isFav,
    required this.isHistory,
  });

  factory UzbEng.fromMap(Map<String, dynamic> json) => UzbEng(
        id: json["_id"],
        uzb: json["uzb"],
        eng: json["eng"],
        eng1: json["eng_1"],
        eng2: json["eng_2"],
        isFav: json["isFav"],
        isHistory: json["isHistory"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "uzb": uzb,
        "eng": eng,
        "eng_1": eng1,
        "eng_2": eng2,
        "isFav": isFav,
        "isHistory": isHistory,
      };
}

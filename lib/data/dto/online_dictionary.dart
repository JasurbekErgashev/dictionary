import 'dart:convert';

List<OnlineDictionary> onlineDictionaryFromJson(String str) =>
    List<OnlineDictionary>.from(
        json.decode(str).map((x) => OnlineDictionary.fromJson(x)));

String onlineDictionaryToJson(List<OnlineDictionary> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlineDictionary {
  OnlineDictionary({
    this.word,
    this.phonetic,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  final String? word;
  final String? phonetic;
  final List<Phonetic>? phonetics;
  final List<Meaning>? meanings;
  final License? license;
  final List<String>? sourceUrls;

  factory OnlineDictionary.fromJson(Map<String, dynamic> json) =>
      OnlineDictionary(
        word: json["word"],
        phonetic: json["phonetic"],
        phonetics: json["phonetics"] == null
            ? []
            : List<Phonetic>.from(
                json["phonetics"]!.map((x) => Phonetic.fromJson(x))),
        meanings: json["meanings"] == null
            ? []
            : List<Meaning>.from(
                json["meanings"]!.map((x) => Meaning.fromJson(x))),
        license:
            json["license"] == null ? null : License.fromJson(json["license"]),
        sourceUrls: json["sourceUrls"] == null
            ? []
            : List<String>.from(json["sourceUrls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "phonetic": phonetic,
        "phonetics": phonetics == null
            ? []
            : List<dynamic>.from(phonetics!.map((x) => x.toJson())),
        "meanings": meanings == null
            ? []
            : List<dynamic>.from(meanings!.map((x) => x.toJson())),
        "license": license?.toJson(),
        "sourceUrls": sourceUrls == null
            ? []
            : List<dynamic>.from(sourceUrls!.map((x) => x)),
      };
}

class License {
  License({
    this.name,
    this.url,
  });

  final String? name;
  final String? url;

  factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Meaning {
  Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  final String? partOfSpeech;
  final List<Definition>? definitions;
  final List<String>? synonyms;
  final List<dynamic>? antonyms;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: json["definitions"] == null
            ? []
            : List<Definition>.from(
                json["definitions"]!.map((x) => Definition.fromJson(x))),
        synonyms: json["synonyms"] == null
            ? []
            : List<String>.from(json["synonyms"]!.map((x) => x)),
        antonyms: json["antonyms"] == null
            ? []
            : List<dynamic>.from(json["antonyms"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": definitions == null
            ? []
            : List<dynamic>.from(definitions!.map((x) => x.toJson())),
        "synonyms":
            synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms":
            antonyms == null ? [] : List<dynamic>.from(antonyms!.map((x) => x)),
      };
}

class Definition {
  Definition({
    this.definition,
    this.synonyms,
    this.antonyms,
    this.example,
  });

  final String? definition;
  final List<String>? synonyms;
  final List<dynamic>? antonyms;
  final String? example;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: json["synonyms"] == null
            ? []
            : List<String>.from(json["synonyms"]!.map((x) => x)),
        antonyms: json["antonyms"] == null
            ? []
            : List<dynamic>.from(json["antonyms"]!.map((x) => x)),
        example: json["example"],
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "synonyms":
            synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms":
            antonyms == null ? [] : List<dynamic>.from(antonyms!.map((x) => x)),
        "example": example,
      };
}

class Phonetic {
  Phonetic({
    this.text,
    this.audio,
    this.sourceUrl,
    this.license,
  });

  final String? text;
  final String? audio;
  final String? sourceUrl;
  final License? license;

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        text: json["text"],
        audio: json["audio"],
        sourceUrl: json["sourceUrl"],
        license:
            json["license"] == null ? null : License.fromJson(json["license"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "audio": audio,
        "sourceUrl": sourceUrl,
        "license": license?.toJson(),
      };
}

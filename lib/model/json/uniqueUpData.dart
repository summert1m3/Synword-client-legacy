import 'dart:convert';

class ReplacedWord {
  Word word;
  List<String> synonyms;

  ReplacedWord(this.word, this.synonyms);

  ReplacedWord.fromJson(Map<String, dynamic> json)
    : word = Word.fromJson(json['word']),
      synonyms = List<String>.from(json['synonyms'].map((json) => json));

  Map<String, dynamic> toJson() => {
    'word' : word.toJson(),
    'synonyms' : jsonEncode(synonyms)
  };
}

class UniqueUpData {
  String text;
  List<ReplacedWord> replaced;

  UniqueUpData(this.text, this.replaced);

  UniqueUpData.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        replaced = List<ReplacedWord>.from(json['replaced'].map((json) => ReplacedWord.fromJson(json)));
}

class Word {
  int startIndex;
  int endIndex;

  Word(this.startIndex, this.endIndex);

  Word.fromJson(Map<String, dynamic> json)
    : startIndex = json['startIndex'],
      endIndex = json['endIndex'];

  Map<String, dynamic> toJson() => {
    'startIndex' : startIndex,
    'endIndex' : endIndex
  };
}
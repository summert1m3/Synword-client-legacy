class UniqueUpData {
  String text;
  List<Word> replaced;

  UniqueUpData(this.text, this.replaced);

  UniqueUpData.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        replaced = List<Word>.from(json['replaced'].map((json) => Word.fromJson(json)));
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
class UniqueCheckData {
  double percent;
  List<MatchedPages> matches;

  UniqueCheckData(this.percent, this.matches);

  UniqueCheckData.fromJson(Map<String, dynamic> json)
      : percent = json['percent'],
        matches = List<MatchedPages>.from(json['matches'].map((json) => MatchedPages.fromJson(json)));

  Map<String, dynamic> toJson() =>
  {
    'percent' : percent,
    'matches' : matches
  };
}

class MatchedPages {
  String url;
  double percent;

  MatchedPages(this.url, this.percent);

  MatchedPages.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        percent = json['percent'];
}
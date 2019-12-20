class AdventureList {
  final List<Adventure1> adventure;

  AdventureList({this.adventure});

  factory AdventureList.fromJson(List<dynamic> parsedJson) {
    List<Adventure1> firstAdventure = new List<Adventure1>();
    firstAdventure = parsedJson.map((i) => Adventure1.fromJson(i)).toList();

    return AdventureList(
      adventure: firstAdventure,
    );
  }
}

class Adventure1 {
  final int id;
  final String text;
  final List<Options> options;

  Adventure1({this.id, this.text, this.options});

  factory Adventure1.fromJson(Map<String, dynamic> json) {
    var list = json['options'] as List;
    List<Options> optionsList = list.map((i) => Options.fromJson(i)).toList();

    return Adventure1(id: json['id'], text: json['text'], options: optionsList);
  }
}

class Options {
  final int index;
  final String text;
  final int nextText;
  final Map<String, dynamic> setState;
  final Map<String, dynamic> requiredState;

  Options(
      {this.index,
      this.text,
      this.nextText,
      this.setState,
      this.requiredState});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
        index: json['index'],
        text: json['text'],
        nextText: json['nextText'],
        setState: json['setState'],
        requiredState: json['requiredState']);
  }
}

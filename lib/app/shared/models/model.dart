class AdventureList {
  final List<Adventure1> adventure;

  AdventureList({this.adventure});

  factory AdventureList.fromJson(Map<String, dynamic> json) {
    List<Adventure1> firstAdventure = new List<Adventure1>();
    json['firstAdventure'].forEach((v) {
      firstAdventure.add(new Adventure1.fromJson(v));
    });

    return AdventureList(adventure: firstAdventure);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.adventure != null) {
      data['firstAdventure'] = this.adventure.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['text'] = this.text;
    data['nextText'] = this.nextText;
    if (this.setState != null) data['setState'] = this.setState;

    if (this.requiredState != null) data['requiredState'] = this.requiredState;
    return data;
  }
}

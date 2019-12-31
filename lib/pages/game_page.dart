import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_adventure_app/models/model.dart';
import 'package:text_adventure_app/services/loadJsons.dart';
import 'package:text_adventure_app/services/playerPrefs.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdventureList history;

  VideoPlayerController _controller =
      VideoPlayerController.asset('videos/desert.mp4');

  int nextText;
  Map<String, dynamic> choiceState;

  @override
  void initState() {
    loadJson();
    readPlayerPrefs();

    if (Platform.isAndroid || Platform.isIOS) initializeVideo();

    super.initState();
  }

  void _changeState(int itemIndex) {
    setState(() {
      choiceState = history.adventure[nextText].options[itemIndex].setState;

      if (nextText < history.adventure.length) {
        nextText = history.adventure[nextText].options[itemIndex].nextText - 1;
      } else {
        nextText = 0;
      }

      SaveGame.save(nextText);
    });
  }

  void readPlayerPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getInt('nextText') ?? 0;

    print('read: $value');

    nextText = value;
  }

  Future loadJson() async {
    await Aventura1Json.loadAdventure1();
    history = new AdventureList.fromJson(Aventura1Json.jsonResponse);
  }

  Future<void> initializeVideo() async {
    await _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(1.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: loadJson(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
              case ConnectionState.active:
                return CircularProgressIndicator();
                break;
              case ConnectionState.done:
                return Card(elevation: 5, child: aventura1(context));
                break;
            }
          },
        ),
      ),
    );
  }

  Widget aventura1(BuildContext context) {
    return (ListView(children: <Widget>[
      Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 10),
        child: Text(
          history.adventure[(nextText)].text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      GridView.count(
          childAspectRatio: MediaQuery.of(context).size.height * 0.0020,
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          padding: EdgeInsets.all(15.0),
          children: history.adventure[(nextText)].options
              .map((item) => (item.requiredState == null ||
                      item.requiredState.toString() == choiceState.toString()
                  ? RaisedButton(
                      color: Colors.amber[200],
                      padding: EdgeInsets.all(10),
                      elevation: 5,
                      child: Text(
                        item.text,
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        _changeState(item.index);
                      },
                    )
                  : Container()))
              .toList()),
    ]));
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

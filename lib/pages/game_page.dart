import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:text_adventure_app/models/model.dart';
import 'package:text_adventure_app/services/loadJsons.dart';
import 'package:text_adventure_app/services/playerPrefs.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Aventura1Json jsonHistory = Aventura1Json();
  AdventureList _history;

  VideoPlayerController _controller =
      VideoPlayerController.asset('videos/desert.mp4');

  final SaveGame playerPrefs = SaveGame();

  int nextText;
  Map<String, dynamic> choiceState;

  @override
  void initState() {
    loadJson();
    readPlayerPrefs();

    //if (Platform.isAndroid || Platform.isIOS )
    initializeVideo();

    super.initState();
  }

  Future loadJson() async {
    await jsonHistory.loadAdventure1();
    _history = jsonHistory.history;
  }

  Future<void> initializeVideo() async {
    await _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0.5);
      });
    });
  }

  Future<void> readPlayerPrefs() async {
    await playerPrefs.read();

    nextText = playerPrefs.readValue;
  }

  void _changeState(int itemIndex) {
    setState(() {
      choiceState = _history.adventure[nextText].options[itemIndex].setState;

      if (nextText < _history.adventure.length) {
        nextText = _history.adventure[nextText].options[itemIndex].nextText - 1;
      } else {
        nextText = 0;
      }
      playerPrefs.save(nextText);
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
          _history.adventure[(nextText)].text,
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

          controller: null,
          physics: null,
          primary: false,
          childAspectRatio: MediaQuery.of(context).size.height * 0.0020,
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          padding: EdgeInsets.all(15.0),
          children: _history.adventure[(nextText)].options
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

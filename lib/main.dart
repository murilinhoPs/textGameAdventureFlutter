import 'dart:async' show Future;
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:text_adventure_app/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Text Adventure Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdventureList history;

  // VideoPlayerController videoPlayer;

  // ChewieController chewieController;

  Future<String> _loadAdventureAsset() async {
    return await rootBundle.loadString('localJson/adventure1.json');
  }

  Future loadProduct() async {
    String jsonProduct = await _loadAdventureAsset();
    final jsonResponse = json.decode(jsonProduct);
    history = new AdventureList.fromJson(jsonResponse);
  }

  int nextText;
  Map<String, dynamic> choiceState;

  @override
  void initState() {
    super.initState();

    loadProduct();
    nextText = 0;

    // videoPlayer = VideoPlayerController.asset('/videos/Com som.mp4');

    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayer,
    //   aspectRatio: 3 / 2,
    //   autoPlay: true,
    //   looping: true,
    // );
  }

  void _changeState(int itemIndex) {
    setState(() {
      choiceState = history.adventure[nextText].options[itemIndex].setState;

      if (nextText < history.adventure.length) {
        nextText = history.adventure[nextText].options[itemIndex].nextText - 1;
      } else {
        nextText = 0;
      }
    });
  }

  // void dispose() {
  //   super.dispose();

  //   videoPlayer.dispose();
  //   chewieController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: loadProduct(),
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
      
        // Center(
        //   child: Chewie(
        //     controller: chewieController,
        //   ),
        // ),
      
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
}

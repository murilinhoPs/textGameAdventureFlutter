import 'package:flutter/material.dart';
import 'package:text_adventure_app/bloc/text_state_bloc.dart';
import 'package:text_adventure_app/services/loadJsons.dart';
import 'package:text_adventure_app/services/loadVideo.dart';
import 'package:text_adventure_app/services/playerPrefs.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Aventura1Json jsonHistory = Aventura1Json();

  final VideosAssets videosControllers = VideosAssets();

  final SaveGame playerPrefs = SaveGame();

  @override
  void initState() {
    jsonHistory.loadAdventure1();
    AdventureBloc.readPlayerPrefs(context);

    //if (Platform.isAndroid || Platform.isIOS )
    videosControllers.initializeVideo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Stack(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images-americanas.b2w.io/produtos/01/00/sku/43782/4/43782401_2SZ.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('clear game data'),
                  Container(width: 50,
                    child: FlatButton(

                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.clear),
                      onPressed: () => playerPrefs.clearPrefs(),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: FutureBuilder(
                  future: jsonHistory.loadAdventure1(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                      case ConnectionState.active:
                        return CircularProgressIndicator();
                        break;
                      case ConnectionState.done:
                        return aventura1(context);
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aventura1(BuildContext context) {
    return Consumer<TextState>(
      builder: (context, textState, widget) {
        return Consumer<ChoiceState>(builder: (context, choiceState, widget) {
          return ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  jsonHistory.history.adventure[(textState.nextText)].text,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Center(
                child: videosControllers.controller.value.initialized
                    ? AspectRatio(
                        aspectRatio:
                            videosControllers.controller.value.aspectRatio,
                        child: VideoPlayer(videosControllers.controller),
                      )
                    : Container(),
              ),
              GridView.count(
                  primary: false,
                  physics: null,
                  childAspectRatio: MediaQuery.of(context).size.height * 0.0020,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  padding: EdgeInsets.all(30.0),
                  children: jsonHistory
                      .history.adventure[(textState.nextText)].options
                      .map((item) => (item.requiredState == null ||
                              item.requiredState.toString() ==
                                  choiceState.toString()
                          ? FlatButton(
                              shape: BeveledRectangleBorder(
                                side: BorderSide(color: Colors.amber[600]),
                                borderRadius: BorderRadius.all(
                                  Radius.elliptical(10, 7),
                                ),
                              ),
                              splashColor: Colors.amber[300],
                              padding: EdgeInsets.all(10),
                              color: Color.fromRGBO(220, 140, 60, 0.3),
                              child: Text(
                                item.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[850]
                                ),
                              ),
                              onPressed: () {
                                AdventureBloc.changeAdventureState(
                                    context, jsonHistory.history, item.index);
                                print(textState.nextText);
                              },
                            )
                          : Container()))
                      .toList()),
            ],
          );
        });
      },
    );
  }

  void dispose() {
    videosControllers.controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/pages/bloc/narrative_text.dart';
import 'package:text_adventure_app/app/pages/widgets/choices.dart';
import 'package:text_adventure_app/app/shared/global/bloc_methods.dart';
import 'package:text_adventure_app/app/shared/utils/jsons_manager.dart';
import 'package:text_adventure_app/app/shared/utils/loadVideo.dart';
import 'package:text_adventure_app/app/shared/utils/playerPrefs.dart';
import 'package:video_player/video_player.dart';
import '../app_module.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AdventureJson jsonHistory = AdventureJson();

  final VideosAssets videosControllers = VideosAssets();

  final SaveGame playerPrefs = SaveGame();

  final blocMethods = AppModule.to.getDependency<BlocMethods>();

  Future<void> initialize() async {
    await jsonHistory.loadAdventure(file: 'assets/localJson/felipeAdventure.json');
    //videosControllers.initializeVideo();
    await blocMethods.readPlayerPrefs(context);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    videosControllers.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 195, 171, 1),
      body: Center(
        child: SafeArea(
          child: Stack(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('clear game data'),
                  Container(
                    width: 50,
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
                  future: initialize(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                      case ConnectionState.active:
                        return Center(child: CircularProgressIndicator());
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
    return StreamBuilder<int>(
      stream: AppModule.to.bloc<NarrativeTextBloc>().nextNarrativeText,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        return Column(
          children: <Widget>[
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  narrative(snapshot),
                  //videoOrImage(),
                ],
              ),
            ),
            ChoicesWidget(jsonHistory: jsonHistory),
          ],
        );
      },
    );
  }

  Widget narrative(dynamic snapshot) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: SelectableText(
        jsonHistory.adventureList.adventure[snapshot.data].text,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  Widget videoOrImage() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Center(
        child: videosControllers.controller.value.initialized
            ? AspectRatio(
                aspectRatio: videosControllers.controller.value.aspectRatio,
                child: VideoPlayer(
                  videosControllers.controller,
                ),
              )
            : Container(),
      ),
    );
  }
}

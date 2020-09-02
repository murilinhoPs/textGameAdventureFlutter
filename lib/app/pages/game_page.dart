import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:text_adventure_app/app/pages/bloc/narrative_text.dart';
import 'package:text_adventure_app/app/pages/style/notebook_custom_clipper.dart';
import 'package:text_adventure_app/app/pages/widgets/choices.dart';
import 'package:text_adventure_app/app/pages/style/notebook_custom_paint.dart';
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
          mainAxisSize: MainAxisSize.max,
          children: [
            videoOrImage(),
            Divider(
              color: Colors.black45,
              thickness: 4.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 20.0),
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: ClipPath(
                  clipper: NotebookClipper(),
                  child: CustomPaint(
                    painter: NotebookPainter(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 22.0,
                        left: 26.0,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          narrative(snapshot),
                          ChoicesWidget(jsonHistory: jsonHistory),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget narrative(dynamic snapshot) {
    return Container(
      padding: EdgeInsets.only(left: 25, top: 25, right: 25),
      child: SelectableText(
        jsonHistory.adventureList.adventure[snapshot.data].text,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }

  Widget videoOrImage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.0, top: 1.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.397,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/564x/94/7b/ad/947badfba69962a84d80fa1e4afb55c2.jpg'),
          ),
        ),
        // videosControllers.controller.value.initialized
        //     ? AspectRatio(
        //         aspectRatio: videosControllers.controller.value.aspectRatio,
        //         child: VideoPlayer(
        //           videosControllers.controller,
        //         ),
        //       )
        //     : Container(),
      ),
    );
  }
}

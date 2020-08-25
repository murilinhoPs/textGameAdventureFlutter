import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:text_adventure_app/app/app_widget.dart';
import 'package:text_adventure_app/app/pages/bloc/choices_required_state.dart';
import 'package:text_adventure_app/app/pages/bloc/choices_state.dart';
import 'package:text_adventure_app/app/pages/bloc/narrative_text.dart';
import 'package:text_adventure_app/app/shared/global/bloc_methods.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
          (_) => NarrativeTextBloc(),
        ),
        Bloc(
          (_) => ChoiceStateBloc(),
        )
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
          (_) => ChoicesRequiredState(),
        ),
        Dependency(
          (_) => BlocMethods(),
        )
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

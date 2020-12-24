import 'package:text_adventure_app/app/pages/bloc/choices_required_state.dart';
import 'package:text_adventure_app/app/routes.dart';
import 'package:text_adventure_app/app/shared/global/bloc_methods.dart';
import 'package:text_adventure_app/app/pages/bloc/narrative_text.dart';
import 'package:text_adventure_app/app/pages/bloc/choices_state.dart';
import 'package:text_adventure_app/app/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppModule extends StatefulWidget {
  @override
  _AppModuleState createState() => _AppModuleState();
}

class _AppModuleState extends State<AppModule> {
  final getIt = GetIt.instance;

  void getDependencies() {
    getIt.registerSingleton<ChoicesRequiredState>(ChoicesRequiredState());
    getIt.registerSingleton<BlocMethods>(BlocMethods());
    getIt.registerSingleton<Routes>(Routes());
  }

  @override
  void initState() {
    getDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NarrativeTextBloc>(
          create: (_) => NarrativeTextBloc(),
        ),
        BlocProvider<ChoiceStateBloc>(
          create: (_) => ChoiceStateBloc(),
        ),
      ],
      child: AppWidget(),
    );
  }
}

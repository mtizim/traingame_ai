import 'package:app/misc/styleconsts.dart';
import 'package:app/views/camera/camera_view_guard.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:app/views/initial_view.dart';
import 'package:app/views/tickets/tickets_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "TODO come up with a name";
    return MaterialApp(
      title: title,
      theme: ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: C.light,
          onPrimary: C.white,
          secondary: C.dark,
          onSecondary: C.white,
          error: C.mid,
          onError: C.white,
          background: C.white,
          onBackground: C.black,
          surface: C.white,
          onSurface: C.black,
        ),
      ),
      home: BlocProvider(
        create: (context) => GameCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              title,
              style: TS.standard,
            ),
          ),
          body: BlocConsumer<GameCubit, GameCubitState>(
            listener: (context, state) => state.map<void>(
              reset: (_) {},
              // TODO go to the final screen
              finalized: (_) {},
              counting: (c) {
                if (!c.routesKnown) {
                  CameraViewRoute.goTo(context);
                } else if (!c.ticketsKnown) {
                  TicketsViewRoute.goTo(context, replace: true);
                }
              },
            ),
            builder: (context, state) => const InitialScreen(),
          ),
        ),
      ),
    );
  }
}

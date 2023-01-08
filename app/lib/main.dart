import 'package:app/misc/styleconsts.dart';
import 'package:app/views/camera/camera_view_guard.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:app/views/initial_view.dart';
import 'package:app/views/routes_confirmation/routes_confirmation.dart';
import 'package:app/views/summary/summary_view.dart';
import 'package:app/views/tickets/tickets_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "TicketToRide Scanner";
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
          body: BlocConsumer<GameCubit, GameCubitState>(
            listener: (context, state) => state.map<void>(
              reset: (_) {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              finalized: (c) {
                SummaryViewRoute.goTo(context, c.gameState, replace: true);
              },
              counting: (c) {
                if (!c.routesKnown) {
                  CameraViewRoute.goTo(context);
                } else if (!c.routesConfirmed) {
                  RoutesConfirmRoute.goTo(
                    context,
                    c.gameState.getBoardData(),
                    replace: true,
                  );
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

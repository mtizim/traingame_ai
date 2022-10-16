import 'package:app/misc/styleconsts.dart';
import 'package:app/misc/reusable/button.dart';
import 'package:app/views/camera/camera_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            title,
            style: TS.standard,
          ),
        ),
        body: Builder(
            builder: (context) => Center(
                  child: Button(
                      onTap: () => CameraViewRoute.goTo(context),
                      child: const Text(
                        "Camera view",
                        style: TS.standard,
                      )),
                )),
      ),
    );
  }
}

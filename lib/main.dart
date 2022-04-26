import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plaid_page/views/home_view.dart';

void main() async {
  // Setting the UI Style of the System Status Bar to light and dark background
  // and foreground respectively
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white,
  ));

  await dotenv.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0))),
            overlayColor: MaterialStateProperty.all(Colors.grey.shade700),
          ),
        ),
        dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0))),
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
                displaySmall: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 25, color: Colors.white))
            .apply(
              fontFamily: 'Montserrat',
            ),
      ),
      home: const HomeView(),
    );
  }
}

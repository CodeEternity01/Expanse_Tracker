import 'package:flutter/material.dart';
import 'package:expance_tracker/widget/expences.dart';
 import 'package:flutter/services.dart';

// for error displace check it when required also here below inside the material is all for error showing
// @override
// void initState() {
//   super.initState();
//   throw ('This is an Error');
// }

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // For looking the screen view
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((value) {
    // this used for the top where charge and network are.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.red,
        statusBarColor: Color.fromRGBO(219, 74, 136, 1),
      ),
    );
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Material(
        child: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                details.exception.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    };

    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        // this used to add default styleing thems and in which you can change what you want help to avoid writing code from scrach
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
              color: kDarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            // onprimary use for conent on button and primary for background
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          )),
        ),

        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          )),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 14,
                ),
              ),
        ),

        themeMode: ThemeMode.light,
        home: const Expences(),
      ),
    );
  // });
}

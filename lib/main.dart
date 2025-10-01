import 'package:flutter/material.dart';

import 'Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.blueGrey),
        title: 'Covid-19',
        home: const SplashScreen(),
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            behavior: HitTestBehavior.translucent,
            child: child!,
          );
        },
      );
    });
  }
}

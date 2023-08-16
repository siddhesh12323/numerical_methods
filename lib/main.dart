import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
// import 'screens/about.dart';
// import 'screens/bisection.dart';
// import 'screens/bisection_info.dart';
import 'screens/home.dart';
// import 'screens/regula_falsi.dart';
// import 'screens/regula_falsi_info.dart';

void main() {
  runApp(const MyApp());
}

Color brandColor = Color.fromARGB(255, 52, 194, 226);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;
      if (lightDynamic != null && dark != null) {
        lightColorScheme = lightDynamic.harmonized()..copyWith();
        lightColorScheme = lightColorScheme.copyWith(secondary: brandColor);
        darkColorScheme = dark.harmonized();
      } else {
        lightColorScheme = ColorScheme.fromSeed(seedColor: brandColor);
        darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor, brightness: Brightness.dark);
      }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mathematics 3',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const HomePage(),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => const HomePage(),
        //   // '/about':(context) => const About(),
        //   // '/bisection_method': (context) => const Bisection(),
        //   // '/bisection_info': (context) => const BisectionInfo(),
        //   // '/regula_falsi_method': (context) => const RegulaFalsi(),
        //   // '/regula_falsi_info':(context) => const RegulaFalsiInfo(),
        // },
      );
      //If the function is continuous and the convergence speed is important, the Regula Falsi method may be more appropriate. If the function does not change sign between the two endpoints of an interval or if simplicity is desired, the Bisection method may be a better choice.
    });
  }
}

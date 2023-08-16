import 'package:flutter/material.dart';
import 'package:numerical_methods_mathematics/screens/about_numerical_methods.dart';
import 'package:numerical_methods_mathematics/screens/bisection.dart';
import 'package:numerical_methods_mathematics/screens/newton_raphson.dart';
import 'package:numerical_methods_mathematics/screens/numerical_methods_options.dart';
import 'package:numerical_methods_mathematics/screens/regula_falsi.dart';
import 'package:numerical_methods_mathematics/screens/secant.dart';

import 'about_me.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/about');
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) =>
                        const AboutMe()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0, 1);
                      const end = Offset.zero;
                      var curve = Curves.easeIn;
                      var curveTween = CurveTween(curve: curve);
                      final tween =
                          Tween(begin: begin, end: end).chain(curveTween);
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    }));
              },
              icon: const Icon(Icons.info_rounded))
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      //Navigator.pushNamed(context, '/bisection_method');
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              ((context, animation, secondaryAnimation) =>
                                  const NumericalMethods()),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0, 1);
                            const end = Offset.zero;
                            var curve = Curves.easeIn;
                            var curveTween = CurveTween(curve: curve);
                            final tween =
                                Tween(begin: begin, end: end).chain(curveTween);
                            final offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          }));
                    },
                    child: const Text('Numerical Methods')),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextButton(
              //       style: Theme.of(context).textButtonTheme.style,
              //       onPressed: () {
              //         //Navigator.pushNamed(context, '/regula_falsi_method');
              //         Navigator.of(context).push(PageRouteBuilder(
              //         pageBuilder: ((context, animation, secondaryAnimation) =>
              //             const RegulaFalsi()),
              //         transitionsBuilder:
              //             (context, animation, secondaryAnimation, child) {
              //           const begin = Offset(0, 1);
              //           const end = Offset.zero;
              //           var curve = Curves.easeIn;
              //           var curveTween = CurveTween(curve: curve);
              //           final tween =
              //               Tween(begin: begin, end: end).chain(curveTween);
              //           final offsetAnimation = animation.drive(tween);
              //           return SlideTransition(
              //             position: offsetAnimation,
              //             child: child,
              //           );
              //         }));
              //       },
              //       child: const Text('Regula Falsi Method')),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextButton(
              //       style: Theme.of(context).textButtonTheme.style,
              //       onPressed: () {
              //         //Navigator.pushNamed(context, '/bisection_method');
              //         Navigator.of(context).push(PageRouteBuilder(
              //         pageBuilder: ((context, animation, secondaryAnimation) =>
              //             const NewtonRaphson()),
              //         transitionsBuilder:
              //             (context, animation, secondaryAnimation, child) {
              //           const begin = Offset(0, 1);
              //           const end = Offset.zero;
              //           var curve = Curves.easeIn;
              //           var curveTween = CurveTween(curve: curve);
              //           final tween =
              //               Tween(begin: begin, end: end).chain(curveTween);
              //           final offsetAnimation = animation.drive(tween);
              //           return SlideTransition(
              //             position: offsetAnimation,
              //             child: child,
              //           );
              //         }));
              //       },
              //       child: const Text('Newton Raphson Method')),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextButton(
              //       style: Theme.of(context).textButtonTheme.style,
              //       onPressed: () {
              //         //Navigator.pushNamed(context, '/bisection_method');
              //         Navigator.of(context).push(PageRouteBuilder(
              //         pageBuilder: ((context, animation, secondaryAnimation) =>
              //             const Secant()),
              //         transitionsBuilder:
              //             (context, animation, secondaryAnimation, child) {
              //           const begin = Offset(0, 1);
              //           const end = Offset.zero;
              //           var curve = Curves.easeIn;
              //           var curveTween = CurveTween(curve: curve);
              //           final tween =
              //               Tween(begin: begin, end: end).chain(curveTween);
              //           final offsetAnimation = animation.drive(tween);
              //           return SlideTransition(
              //             position: offsetAnimation,
              //             child: child,
              //           );
              //         }));
              //       },
              //       child: const Text('Secant Method'))
            ]),
      ),
    );
  }
}

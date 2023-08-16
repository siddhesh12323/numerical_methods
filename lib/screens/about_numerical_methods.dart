import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 34,
                )),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 30, 0, 0),
                child: Text(
                  'About Numerical Methods',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('a.'),
                        title: const Text(
                              "If the function is continuous and the convergence speed is important then use Regula Falsi method"),
                        //title: const Text('Enter only left hand side of the equation e.g. x ^ 2 - x - 1 and not x ^ 2 - x - 1 = 0'),
                        style: Theme.of(context).listTileTheme.style,
                        //contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('b.'),
                        title: const Text(
                            "If the function does not change sign between the two endpoints of an interval or if simplicity is desired then use Bisection method"),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                  ],
                ),
             
              ),
              
            ]));
  }
}
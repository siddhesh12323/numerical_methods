import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SecantInfo extends StatelessWidget {
  const SecantInfo({super.key});

  @override
  Widget build(BuildContext context) {
    /*
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
                  'About Secant Method',
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
                            "Enter only left hand side of the equation e.g. x ^ 2 - x - 1 and not x ^ 2 - x - 1 = 0"),
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
                            'Enter values of a and b such that f(a) x f(b) < 0. If it is not true the result will be -1'),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('c.'),
                        title: const Text(
                            'Enter error factor in decimal format only e.g. 0.000001 and not 10^-6'),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('d.'),
                        title: const Text(
                            'The minimum error factor is 0.000000000000001'),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('e.'),
                        title: InkWell(
                          onTap: () => _launchURL(
                              'https://en.wikipedia.org/wiki/Secant_method'),
                          child: const Text(
                            'Learn more about Secant method',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                  ],
                ),
              ),
            ]));
    */
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text(
            'About Secant Method',
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('a.'),
              title: const Text(
                  "Use only 'x' as the variable in the equation e.g. x ^ 2 - x - 1"),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('b.'),
              title: const Text(
                  "Use only '*' as multiplication sign e.g. 2 * x and not 2x or 2(x)"),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('c.'),
              title: const Text(
                  "Enter only left hand side of the equation e.g. x ^ 2 - x - 1 and not x ^ 2 - x - 1 = 0"),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('d.'),
              title: const Text(
                  'Enter values of a and b such that f(a) x f(b) < 0. If it is not true the result will be -1'),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('e.'),
              title: const Text(
                  'Enter error factor in decimal format only e.g. 0.000001 and not 10^-6'),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('f.'),
              title:
                  const Text('The minimum error factor is 0.000000000000001'),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('g.'),
              title: const Text(
                  'When the equation is solved for the first time, the execution time may be more than usual as the system loads up the equation solving algorithm. The execution time will be less when the equation is solved again.'),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('h.'),
              title: const Text(
                  'Secant method may return looping or backwards graph.'),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: const Text('i.'),
              title: InkWell(
                onTap: () =>
                    _launchURL('https://en.wikipedia.org/wiki/Secant_method'),
                onLongPress: () {
                  Clipboard.setData(const ClipboardData(
                      text: 'https://en.wikipedia.org/wiki/Secant_method'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('URL copied to clipboard'),
                    ),
                  );
                },
                child: const Text(
                  'Learn more about Secant method',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              style: Theme.of(context).listTileTheme.style,
            ),
          ),
        ),
      ]),
    );
  }

  _launchURL(String url) async {
    // ignore: no_leading_underscores_for_local_identifiers
    Uri _url = Uri.parse(url);
    if (await launchUrl(_url)) {
    } else {
      throw 'Could not launch $_url';
    }
  }
}

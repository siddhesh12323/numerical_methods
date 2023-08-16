import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    final Email email = Email(
      subject: 'Feedback on Numerical Methods Application',
      recipients: ['purnakumbhar1234@gmail.com'],
      isHTML: false,
    );
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
                  'Feedback',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 8, 0, 8),
                child: Text(
                    'Submit feedback, bugs, suggestions or connect with me'),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('a.'),
                        title: InkWell(
                          onTap: () async {
                            await FlutterEmailSender.send(email);
                          },
                          child: const Text(
                            'E-mail',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('c.'),
                        title: InkWell(
                          onTap: () => _launchURL(
                              'https://www.linkedin.com/in/siddheshkdev/'),
                          child: const Text(
                            'LinkedIn',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        style: Theme.of(context).listTileTheme.style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListTile(
                        leading: const Text('c.'),
                        title: InkWell(
                          onTap: () =>
                              _launchURL('https://twitter.com/siddheshk_dev'),
                          child: const Text(
                            'Twitter',
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

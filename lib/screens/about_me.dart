import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: CustomScrollView(
        slivers: [
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
              'Feedback',
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: ListTile(
                  title: Text(
                      'Submit feedback, bugs, suggestions or connect with me')),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: ListTile(
                leading: const Text('b.'),
                title: InkWell(
                  onTap: () => _launchURL('https://twitter.com/siddheshk_dev'),
                  onLongPress: () {
                    Clipboard.setData(const ClipboardData(
                        text: 'https://twitter.com/siddheshk_dev'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Twitter URL copied to clipboard'),
                      ),
                    );
                  },
                  child: const Text(
                    'Twitter (now X)',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                style: Theme.of(context).listTileTheme.style,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: ListTile(
                leading: const Text('c.'),
                title: InkWell(
                  onTap: () =>
                      _launchURL('https://www.linkedin.com/in/siddheshkdev/'),
                  onLongPress: () {
                    Clipboard.setData(const ClipboardData(
                        text: 'https://www.linkedin.com/in/siddheshkdev/'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('LinkedIn URL copied to clipboard'),
                      ),
                    );
                  },
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
          ),
        ],
      ),
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

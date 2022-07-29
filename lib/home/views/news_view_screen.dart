import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  ///Passing state and index from crypto_news widget
  const NewsScreen({Key? key, required this.state, required this.index})
      : super(key: key);
  final state;
  final index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///news title
                Text(
                  state.crypto[index].title,
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ///Source of the title news is given as link
                    TextButton(
                      onPressed: () {
                        String url =
                            'https://cryptopanic.com/news/${state.crypto[index].id}/click/';
                        _launchUrl(url);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.link,
                            color: Colors.white70,
                          ),
                          Text(
                            '${state.crypto[index].domain}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),

                    ///News published time
                    Text(
                      format(
                        state.crypto[index].publishedAt!.subtract(
                          Duration(minutes: 1),
                        ),
                        locale: 'en',
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///function to launch url from app to browser
Future<void> _launchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    print('Can\'t launch url');
  }
}

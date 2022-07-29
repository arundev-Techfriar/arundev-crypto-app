import 'package:crypto_news_app/home/bloc/crypto_bloc.dart';
import 'package:crypto_news_app/home/views/news_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart';

class CryptoNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///CryptoBloc and CryptoState is passed in BlocBuilder
    return BlocConsumer<CryptoBloc, CryptoState>(
      listener: (context, state) {
        ///Checks for new data from api in every 60 seconds and updates news
        Future.delayed(
          Duration(seconds: 60),
          () => context.read<CryptoBloc>().add(LoadCryptoApiEvent()),
        );
      },
      builder: (context, state) {
        ///shows circular indicator when loading news when app opens
        if (state is CryptoLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }

        ///Displays data in List view if the state is CryptoLoadedState
        if (state is CryptoLoadedState) {
          return ListView.separated(
            itemCount: state.crypto.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  ///shows news published time
                  leading: Text(
                    format(
                      state.crypto[index].publishedAt!.subtract(
                        Duration(minutes: 1),
                      ),
                      locale: 'en_short',
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  minLeadingWidth: 10,
                  title: Column(
                    children: [
                      Wrap(
                        children: [
                          ///On press on news title navigates to news_view_page
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsScreen(
                                    ///passing state and index to news_view_page
                                    state: state,
                                    index: index,
                                  ),
                                ),
                              );
                            },

                            ///News title text
                            child: Text(
                              state.crypto[index].title.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
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
                                      color: Colors.lightBlueAccent,
                                    ),
                                    Text(
                                      '${state.crypto[index].domain}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///Shows crypto currency type if mentioned in the news title
                  trailing: Text(
                    '${state.crypto[index].currencies?[0].code ?? ''}',
                    style: TextStyle(color: Color(0xffff9933)),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.white70,
            ),
          );
        }
        return Container();
      },
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

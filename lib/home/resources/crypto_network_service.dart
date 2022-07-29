import 'package:crypto_news_app/home/model/crypto_news_model.dart';
import 'package:http/http.dart';

class CryptoNewsService {
  ///method used to fetch data from API provided cryptopanic.com
  Future<Crypto> getCryptoNews() async {
    String url =
        "https://cryptopanic.com/api/v1/posts/?auth_token=78ca22457c0e92e1ee19e23ce2ee1e13564e35c6&public=true";
    final response = await get(Uri.parse(url));
    final activity = cryptoFromJson(response.body);

    ///returns the data from api in activity.
    return activity;
  }
}

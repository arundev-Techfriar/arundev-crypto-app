import 'dart:convert';

Crypto cryptoFromJson(String str) => Crypto.fromJson(json.decode(str));
String cryptoToJson(Crypto data) => json.encode(data.toJson());

///model class which used for the API from cryptopanic.com
class Crypto {
  Crypto({
    required this.results,
  });

  List<Result> results;

  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.kind,
    this.domain,
    this.title,
    this.publishedAt,
    this.slug,
    this.id,
    this.url,
    this.currencies,
  });

  Kind? kind;
  String? domain;
  String? title;
  DateTime? publishedAt;
  String? slug;
  int? id;
  String? url;
  List<Currency>? currencies;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        kind: kindValues.map[json["kind"]],
        domain: json["domain"],
        title: json["title"],
        publishedAt: DateTime.parse(json["published_at"]),
        slug: json["slug"],
        id: json["id"],
        url: json["url"],
        currencies: json["currencies"] == null
            ? null
            : List<Currency>.from(
                json["currencies"].map((x) => Currency.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kindValues.reverse[kind],
        "domain": domain,
        "title": title,
        "published_at": publishedAt?.toIso8601String(),
        "slug": slug,
        "id": id,
        "url": url,
        "currencies": currencies == null
            ? null
            : List<dynamic>.from(currencies!.map((x) => x.toJson())),
      };
}

class Currency {
  Currency({
    this.code,
    this.title,
    this.slug,
    this.url,
  });

  String? code;
  String? title;
  String? slug;
  String? url;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        title: json["title"],
        slug: json["slug"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "slug": slug,
        "url": url,
      };
}

enum Kind { MEDIA, NEWS }

final kindValues = EnumValues({"media": Kind.MEDIA, "news": Kind.NEWS});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}

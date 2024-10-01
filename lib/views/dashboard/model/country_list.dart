// To parse this JSON data, do
//
//     final countryDetails = countryDetailsFromJson(jsonString);

import 'dart:convert';

List<CountryDetailsModel> countryDetailsFromJson(String str) =>
    List<CountryDetailsModel>.from(
        json.decode(str).map((x) => CountryDetailsModel.fromJson(x)));

String countryDetailsToJson(List<CountryDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryDetailsModel {
  final Name? name;
  final Map<String, Currency>? currencies;
  final Flags? flags;
  final String region;

  factory CountryDetailsModel.fromJson(Map<String, dynamic> json) =>
      CountryDetailsModel(
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        currencies: json["currencies"] == null
            ? null
            : Map.from(json["currencies"]!).map(
                (k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))),
        flags: json["flags"] == null ? null : Flags.fromJson(json["flags"]),
        region: json["region"] ?? '',
      );

  CountryDetailsModel({
    required this.name,
    this.currencies,
    required this.flags,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
        "name": name!.toJson(),
        "currencies": Map.from(currencies!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "flags": flags!.toJson(),
        "region": region,
      };
}

class Currency {
  final String name;
  final String symbol;

  Currency({
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"] ?? '',
        symbol: json["symbol"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Flags {
  final String png;
  final String svg;
  final String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"] ?? '',
        svg: json["svg"] ?? '',
        alt: json["alt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
        "alt": alt,
      };
}

class Name {
  final String common;
  final String official;
  final Map<String, Translation>? nativeName;

  Name({
    required this.common,
    required this.official,
    this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"] ?? '',
        official: json["official"] ?? '',
        nativeName: json["nativeName"] == null
            ? null
            : Map.from(json["nativeName"]!).map((k, v) =>
                MapEntry<String, Translation>(k, Translation.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
        "nativeName": Map.from(nativeName!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Translation {
  final String official;
  final String common;

  Translation({
    required this.official,
    required this.common,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        official: json["official"] ?? '',
        common: json["common"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "official": official,
        "common": common,
      };
}

class PostalCode {
  final String format;
  final String? regex;

  PostalCode({
    required this.format,
    this.regex,
  });

  factory PostalCode.fromJson(Map<String, dynamic> json) => PostalCode(
        format: json["format"],
        regex: json["regex"],
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "regex": regex,
      };
}

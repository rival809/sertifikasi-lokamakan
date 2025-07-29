// To parse this JSON data, do
//
//     final searchRestaurantModel = searchRestaurantModelFromJson(jsonString);

import 'dart:convert';

import 'package:base/models/detail_restaurant_model.dart';

SearchRestaurantModel searchRestaurantModelFromJson(String str) =>
    SearchRestaurantModel.fromJson(json.decode(str));

String searchRestaurantModelToJson(SearchRestaurantModel data) =>
    json.encode(data.toSearchJson());
String listRestaurantModelToJson(SearchRestaurantModel data) =>
    json.encode(data.toListJson());

class SearchRestaurantModel {
  bool? error;
  int? count;
  String? message;
  int? founded;
  List<Restaurant>? restaurants;

  SearchRestaurantModel({
    this.error,
    this.founded,
    this.message,
    this.count,
    this.restaurants,
  });

  SearchRestaurantModel copyWith({
    bool? error,
    int? count,
    String? message,
    int? founded,
    List<Restaurant>? restaurants,
  }) =>
      SearchRestaurantModel(
        error: error ?? this.error,
        count: count ?? this.count,
        message: message ?? this.message,
        founded: founded ?? this.founded,
        restaurants: restaurants ?? this.restaurants,
      );

  factory SearchRestaurantModel.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantModel(
        error: json["error"],
        count: json["count"],
        message: json["message"],
        founded: json["founded"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toSearchJson() => {
        "error": error,
        "founded": founded,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
  Map<String, dynamic> toListJson() => {
        "error": error,
        "count": count,
        "message": message,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

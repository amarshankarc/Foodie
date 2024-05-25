// To parse this JSON data, do
//
//     final restaurants = restaurantsFromJson(jsonString);

import 'dart:convert';

import 'menu_model.dart';

List<Restaurants> restaurantsFromJson(String str) => List<Restaurants>.from(json.decode(str).map((x) => Restaurants.fromJson(x)));

String restaurantsToJson(List<Restaurants> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurants {
  String restaurantId;
  List<TableMenuList> tableMenuList;

  Restaurants({
    required this.restaurantId,
    required this.tableMenuList,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
    restaurantId: json["restaurant_id"],
    tableMenuList: List<TableMenuList>.from(json["table_menu_list"].map((x) => TableMenuList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurant_id": restaurantId,
    "table_menu_list": List<dynamic>.from(tableMenuList.map((x) => x.toJson())),
  };
}



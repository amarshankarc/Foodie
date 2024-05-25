import 'add_on_model.dart';

class CategoryDish {
  String dishId;
  String dishName;
  String dishImage;
  String dishDescription;
  String nexturl;
  dynamic dishType;
  dynamic dishCalories;
  dynamic dishPrice;
  int? quantity;
  List<AddonCat> addonCat;

  CategoryDish({
    required this.dishId,
    required this.dishName,
    required this.dishImage,
    required this.dishDescription,
    required this.nexturl,
    required this.dishType,
    required this.dishCalories,
    required this.dishPrice,
    required this.addonCat,
    this.quantity
  });

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
    dishId: json["dish_id"],
    dishName: json["dish_name"],
    dishImage: json["dish_image"],
    dishDescription: json["dish_description"],
    nexturl: json["nexturl"],
    dishType: json["dish_Type"],
    dishCalories: json["dish_calories"],
    dishPrice: json["dish_price"],
      quantity: json["quantity"],
    addonCat: List<AddonCat>.from(json["addonCat"].map((x) => AddonCat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dish_id": dishId,
    "dish_name": dishName,
    "dish_image": dishImage,
    "dish_description": dishDescription,
    "nexturl": nexturl,
    "dish_Type": dishType,
    "dish_calories": dishCalories,
    "dish_price": dishPrice,
    "quantity":quantity,
    "addonCat": List<dynamic>.from(addonCat.map((x) => x.toJson())),
  };
}
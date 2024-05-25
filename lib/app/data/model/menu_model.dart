import 'dish_model.dart';

class TableMenuList {
  String menuCategory;
  String menuCategoryId;
  List<CategoryDish> categoryDishes;

  TableMenuList({
    required this.menuCategory,
    required this.menuCategoryId,
    required this.categoryDishes,
  });

  factory TableMenuList.fromJson(Map<String, dynamic> json) => TableMenuList(
    menuCategory: json["menu_category"],
    menuCategoryId: json["menu_category_id"],
    categoryDishes: List<CategoryDish>.from(json["category_dishes"].map((x) => CategoryDish.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "menu_category": menuCategory,
    "menu_category_id": menuCategoryId,
    "category_dishes": List<dynamic>.from(categoryDishes.map((x) => x.toJson())),
  };
}
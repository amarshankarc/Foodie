import 'package:flutter/material.dart';
import 'package:foodie/app/data/model/dish_model.dart';
import 'package:foodie/app/data/model/menu_model.dart';
import 'package:foodie/app/data/repostory/restaurant.dart';
import 'package:get/get.dart';

import '../../../data/model/restaurant_model.dart';

class HomeController extends GetxController {
  // all Data about a Restaurant's Dishes To sale
  RxList<Restaurants> restaurant = <Restaurants>[].obs;

  // menuList is selected Default By First Element of RestaurantList
  RxList<TableMenuList> menuList = <TableMenuList>[].obs;

  RxInt selectedMenuIndex = 0.obs;

  // dishList is to be added According to Selection Of MenuList
  RxList<CategoryDish> dishList = <CategoryDish>[].obs;

  // flag to indicate ApiCall
  RxBool isLoading = false.obs;

  // scaffoldKey For Opening Drawer
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  PageController pageController = PageController();

  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> fetchData() async {
    // loding start
    isLoading.value = true;
    restaurant.value = await RestaurantData.fetch();
    menuList.value = restaurant[0].tableMenuList;
    // fist element of restaurant list is the default selected menu
    selectedMenuIndex.value = 0;
    dishList.value = menuList[0].categoryDishes;
    // loading end
    isLoading.value = true;
  }

  void menuSelection(int index) {
    selectedMenuIndex.value = index;
    dishList.value = menuList[index].categoryDishes;
  }
}

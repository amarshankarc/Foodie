import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/data/repostory/signin.dart';
import 'package:foodie/app/data/repostory/user.dart';
import 'package:foodie/app/utils/asset_helper.dart';
import 'package:foodie/app/utils/err_m.dart';
import 'package:foodie/app/utils/my_theme.dart';
import 'package:get/get.dart';

import '../../../data/repostory/cart.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: Get.height * .4,
              width: Get.width,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: Get.height * .05,
                    backgroundImage: UserData.userInfo.photoURL != null
                        ? CachedNetworkImageProvider(
                            UserData.userInfo.photoURL!,
                          )
                        : AssetImage(AssetHelper.defaultDP),
                  ),
                  MyTheme.space(height: .02),
                  Text(
                    UserData.userInfo.displayName!=null
                        ? UserData.userInfo.displayName.toString()
                        : UserData.userInfo.phoneNumber!,
                    style: MyTheme.poppinsBold(color: MyTheme.white),
                  ),
                  MyTheme.space(height: .01),
                  Text(
                    "UID : ${UserData.userInfo.uid}",
                    maxLines: 1,
                    style: MyTheme.poppinsNormal(color: MyTheme.white),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                SignIn.auth.signOut();
                Get.offAllNamed(Routes.LOGIN);
              },
              child: Row(
                children: [
                  Text(
                    "Logout",
                    style: MyTheme.poppinsNormal(fontSize: .022),
                  ),
                  MyTheme.space(width: .02),
                  const Icon(Icons.logout)
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => controller.scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu)),
        actions: [
          Obx(
            () => Badge(
              isLabelVisible: Cart.cartItems.isNotEmpty ? true : false,
              offset: const Offset(12, 0),
              backgroundColor: Colors.red,
              label: Obx(
                () => Text(
                  Cart.cartItems.length.toString(),
                ),
              ),
              textColor: Colors.white,
              alignment: Alignment.topCenter,
              child: MaterialButton(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                onPressed: () {
                  Get.toNamed(Routes.CART);
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * .055,
            width: Get.width,
            child: Obx(
              () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.menuList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      radius: 20,
                      onTap: () {
                        controller.menuSelection(index);
                        controller.pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                MyTheme.symmetricPadding(width: .05, height: 0),
                            child: Obx(
                              () => Text(
                                controller.menuList[index].menuCategory,
                                style:
                                    controller.selectedMenuIndex.value == index
                                        ? MyTheme.poppinsBold(
                                            fontSize: .022, color: Colors.red)
                                        : MyTheme.poppinsNormal(fontSize: .020),
                              ),
                            ),
                          ),
                          Obx(
                            () => Divider(
                              color: controller.selectedMenuIndex.value == index
                                  ? Colors.red
                                  : Colors.transparent,
                              height: Get.height * .02,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
              child: Obx(
            () => PageView.builder(
              controller: controller.pageController,
              itemCount: controller.menuList.length,
              onPageChanged: (index) {
                controller.menuSelection(index);
              },
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => ListView.builder(
                    itemCount: controller.dishList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: MyTheme.symmetricPadding(width: .05),
                            child: SizedBox(
                              width: Get.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.dishList[index].dishName,
                                          maxLines: 2,
                                          style: MyTheme.poppinsBold(
                                              fontWeight: FontWeight.w600,
                                              fontSize: .020),
                                        ),
                                        MyTheme.space(height: .01),
                                        Row(
                                          children: [
                                            Text(
                                              "INR ${double.parse(controller.dishList[index].dishPrice.toString()).toInt()}",
                                              style: MyTheme.poppinsNormal(
                                                  fontSize: .018),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${double.parse(controller.dishList[index].dishCalories.toString()).toInt()} Calories",
                                              style: MyTheme.poppinsNormal(
                                                  fontSize: .018),
                                            )
                                          ],
                                        ),
                                        MyTheme.space(height: .01),
                                        Text(
                                          controller
                                              .dishList[index].dishDescription,
                                          textAlign: TextAlign.justify,
                                          style: MyTheme.poppinsNormal(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        MyTheme.space(height: .02),
                                        Container(
                                          height: Get.height * .05,
                                          width: Get.width * .3,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    if (Cart.cartItems.any(
                                                        (element) =>
                                                            element.dishId ==
                                                            controller
                                                                .dishList[index]
                                                                .dishId)) {
                                                      Cart.removeQuantity(
                                                          index: Cart.cartItems
                                                              .indexWhere((item) =>
                                                                  item.dishId ==
                                                                  controller
                                                                      .dishList[
                                                                          index]
                                                                      .dishId));
                                                    } else {
                                                      showMsg("Please add item ",
                                                          "Quantity is zero");
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: MyTheme.white,
                                                  )),
                                              Obx(
                                                () => Text(
                                                  Cart.cartItems.any((element) =>
                                                          element.dishId ==
                                                          controller.dishList[index]
                                                              .dishId)
                                                      ? Cart
                                                          .cartItems[Cart.cartItems
                                                              .indexWhere((item) =>
                                                                  item.dishId ==
                                                                  controller
                                                                      .dishList[
                                                                          index]
                                                                      .dishId)]
                                                          .quantity
                                                          .toString()
                                                      : "0",
                                                  style: MyTheme.poppinsNormal(
                                                      color: MyTheme.white,
                                                      fontSize: .020),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    if (Cart.cartItems.contains(
                                                        controller
                                                            .dishList[index])) {
                                                      Cart.addQuantity(
                                                          index: Cart.cartItems
                                                              .indexWhere((item) =>
                                                                  item.dishId ==
                                                                  controller
                                                                      .dishList[
                                                                          index]
                                                                      .dishId));
                                                    } else {
                                                      controller.dishList[index]
                                                          .quantity = 1;
                                                      Cart.addProduct(
                                                          dish: controller
                                                              .dishList[index]);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: MyTheme.white,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        MyTheme.space(height: .01),
                                        Obx(
                                          () => Visibility(
                                            visible: controller.dishList[index]
                                                    .addonCat.isNotEmpty
                                                ? true
                                                : false,
                                            child: Text(
                                              "Customization is available",
                                              style: MyTheme.poppinsNormal(
                                                  color: Colors.red),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: MyTheme.allPadding(left: .02),
                                      child: SizedBox(
                                        height: Get.height * .1,
                                        width: Get.width,
                                        child: CachedNetworkImage(
                                          imageUrl: controller
                                              .dishList[index].dishImage,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}

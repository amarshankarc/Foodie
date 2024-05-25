import 'package:flutter/material.dart';
import 'package:foodie/app/utils/err_m.dart';
import 'package:foodie/app/utils/my_theme.dart';
import 'package:get/get.dart';

import '../../../data/repostory/cart.dart';
import '../../../routes/app_pages.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Summary',
            style: MyTheme.poppinsNormal(fontSize: .022),
          ),
          elevation: 2,
        ),
        body: Column(
          children: [
            Padding(
              padding: MyTheme.symmetricPadding(width: .05, height: .02),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: MyTheme.symmetricPadding(width: .01, height: .0),
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * .07,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Obx(() => Text(
                                "${Cart.cartItems.length} Dishes - ${Cart.cartTotalItem} item",
                                style: MyTheme.poppinsNormal(
                                    color: MyTheme.white, fontSize: .020),
                              )),
                        ),
                      ),
                      MyTheme.space(height: .02),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 0,
                            minWidth: 0,
                            maxHeight: Get.height * .65),
                        child: Obx(
                          () => ListView.builder(
                              shrinkWrap: true,
                              itemCount: Cart.cartItems.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * .1,
                                      width: Get.width,
                                      child: Padding(
                                        padding: MyTheme.allPadding(left: .02),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Cart.cartItems[index]
                                                          .dishName,
                                                      maxLines: 2,
                                                      style:
                                                          MyTheme.poppinsBold(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: .020),
                                                    ),
                                                    Text(
                                                      "INR ${double.parse(Cart.cartItems[index].dishPrice.toString()).toInt()}",
                                                      style:
                                                          MyTheme.poppinsNormal(
                                                              fontSize: .018),
                                                    ),
                                                    Text(
                                                      "${double.parse(Cart.cartItems[index].dishCalories.toString()).toInt()} Calories",
                                                      style:
                                                          MyTheme.poppinsNormal(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: .014),
                                                    )
                                                  ],
                                                )),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: Get.height * .05,
                                                width: Get.width * .3,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Cart.removeQuantity(
                                                              index: index);
                                                        },
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color: MyTheme.white,
                                                        )),
                                                    Obx(
                                                      () => Text(
                                                        Cart.cartItems[index]
                                                            .quantity
                                                            .toString(),
                                                        style: MyTheme
                                                            .poppinsNormal(
                                                                color: MyTheme
                                                                    .white,
                                                                fontSize: .020),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          Cart.addQuantity(
                                                              index: index);
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: MyTheme.white,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Obx(
                                                () => Center(
                                                  child: Text(
                                                    "INR ${Cart.cartItems[index].quantity! * (double.parse(Cart.cartItems[index].dishPrice.toString()).toInt())}",
                                                    style:
                                                        MyTheme.poppinsNormal(
                                                            fontSize: .020),
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
                              }),
                        ),
                      ),
                      MyTheme.space(height: .02),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: MyTheme.symmetricPadding(width: .05, height: .01),
              child: InkWell(
                onTap: () {
                  if(Cart.cartItems.isNotEmpty) {
                    Cart.clear();
                    showMsg("Order successfully placed", "Order Status",
                        isSuccess: true);
                    Get.offNamed(Routes.HOME);
                  }else{
                    showMsg("Please Select Products", "Order Status",);
                  }
                },
                child: Container(
                  height: Get.height * .07,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(60)),
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: MyTheme.poppinsBold(
                          color: MyTheme.white, fontSize: .024),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

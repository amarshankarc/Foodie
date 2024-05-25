import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../utils/local_store.dart';
import '../model/dish_model.dart';

abstract class Cart {
  // key of store data
  static const String _key = "cart";

  // function to add data to Local Store
  static void _addToLocal() => LocalStore.setData(_key, cartItems);

  static RxList<CategoryDish> cartItems = <CategoryDish>[].obs;

  // for cart total
  static RxString cartTotal = "0".obs;

  // total number of quantity
  static RxString cartTotalItem = "0".obs;

  // to Update Cart Data to UI as well as LocalStore
  static void _updateData() {
    _addToLocal();
    _calculateTotal();
    cartItems.refresh();
  }

  // To calculate cart total price
  static String _calculateTotal() {
    int total = 0;
    int quantityTotal = 0;
    for (var element in cartItems) {
      int quantity = element.quantity ?? 1;
      quantityTotal = quantityTotal + quantity;
      int price = double.parse(element.dishPrice.toString()).toInt();
      total = total + (quantity * price);
    }
    cartTotal.value = total.toString();
    cartTotalItem.value = quantityTotal.toString();
    return total.toString();
  }

  static void fetchHistory() {
    // fetch Data from localStore
    dynamic data = LocalStore.getData(_key);
    if (data != null) {
      cartItems.value =
          List<CategoryDish>.from(data.map((x) => CategoryDish.fromJson(x)));
      _calculateTotal();
    }
  }

  static void addProduct({required CategoryDish dish}) {
    if (cartItems.any((element) => element.dishId == dish.dishId)) {
      // Dish which Already present in cart
      for (var element in cartItems) {
        if (element.dishId == dish.dishId) {
          element.quantity = element.quantity! + 1;
          _updateData();
          break;
        }
      }
    } else {
      // new dish
      cartItems.add(dish);
    }
    _updateData();
  }

  static void addQuantity({required int index}) {
    cartItems[index].quantity = (cartItems[index].quantity! + 1);
    _updateData();
  }

  static void removeQuantity({required int index}) {
    if (cartItems[index].quantity == 1) {
      cartItems.removeAt(index);
      _updateData();
    } else if (cartItems[index].quantity != null) {
      cartItems[index].quantity = (cartItems[index].quantity! - 1);
      _updateData();
    }
  }
  //To Clear all Data In  Local Store
  static void clear() {
    cartItems.clear();
    _updateData();
  }
}

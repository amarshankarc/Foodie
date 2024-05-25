import 'package:get/get.dart';

import 'package:foodie/app/modules/cart/bindings/cart_binding.dart';
import 'package:foodie/app/modules/cart/views/cart_view.dart';
import 'package:foodie/app/modules/home/bindings/home_binding.dart';
import 'package:foodie/app/modules/home/views/home_view.dart';
import 'package:foodie/app/modules/login/bindings/login_binding.dart';
import 'package:foodie/app/modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
  ];
}

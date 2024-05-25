import 'package:foodie/app/data/api/call_restaurant.dart';
import 'package:foodie/app/data/model/restaurant_model.dart';

abstract class RestaurantData{
  // Call Api
  static Future<List<Restaurants>> fetch() async {
    List<Restaurants> data = await RestaurantsApi.fetchData();
    return data;
  }
}
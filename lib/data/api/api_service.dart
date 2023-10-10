import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> getListRestaurant() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return restaurantResultFromJson(response.body);
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(
      String restaurantId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/detail/$restaurantId"));
    if (response.statusCode == 200) {
      return detailRestaurantResultFromJson(response.body);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<SearchRestaurantResult> getSearchRestaurant(String querySearch) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/search?q=$querySearch"));
    if (response.statusCode == 200) {
      return searchRestaurantResultFromJson(response.body);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}

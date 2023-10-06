import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';
import 'package:restaurant_app/util/state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    searchRestaurant('');
  }

  late SearchRestaurantResult _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchRestaurantResult get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String keyword) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getSearchRestaurant(keyword);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'No Internet connection. Make sure that Wi-Fi or mobile data is turned on, the try again.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/util/state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService, required restaurantId}) {
    _getDetailRestaurant(restaurantId);
  }

  late DetailRestaurantResult _detailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantResult get result => _detailResult;

  ResultState get state => _state;

  Future<dynamic> _getDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(restaurantId);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = restaurant;
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

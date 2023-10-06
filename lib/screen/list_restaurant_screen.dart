import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/detail_restaurant_screen.dart';
import 'package:restaurant_app/screen/search_restaurant_screen.dart';
import 'package:restaurant_app/util/state.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';

class ListRestaurantScreen extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const ListRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          )
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return ItemRestaurant(
                    restaurant: state.result.restaurants[index]);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Hero(
      tag: restaurant.pictureId,
      child: Image.network(
        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
    ),
    title: Text(restaurant.name),
    subtitle: Row(
      children: [
        Text(restaurant.rating.toString()),
        const SizedBox(
          width: 8,
        ),
        Text(restaurant.city)
      ],
    ),
    onTap: (() {
      Navigator.pushNamed(context, DetailRestaurantScreen.routeName,
          arguments: restaurant.id);
    }),
  );
}

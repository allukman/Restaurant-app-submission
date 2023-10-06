import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/util/state.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/search_textfield.dart';
import 'package:restaurant_app/widgets/view_empty.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  static const String searchTitle = 'Search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var keyword = "";

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          return Hero(
              tag: SearchScreen.routeName,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  SearchTextField(
                    readOnly: false,
                    autoFocus: true,
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          state.searchRestaurant(text);
                        });
                      }
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 12.0 : 0.0),
                  child: ItemRestaurant(
                      restaurant: state.result.restaurants[index]),
                );
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: ViewEmpty(
                message: state.message,
                state: ResultState.noData,
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: ViewEmpty(
                message: state.message,
                state: ResultState.error,
              ),
            );
          } else {
            return Center(
              child: ViewEmpty(
                message: state.message,
                state: ResultState.error,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(
          SearchScreen.searchTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchTextField(),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Row(
          children: [
            CupertinoNavigationBarBackButton(
              color: Theme.of(context).primaryColor,
              onPressed: () => {Navigator.pop(context)},
            ),
            Text(
              SearchScreen.searchTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            _buildSearchTextField(),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

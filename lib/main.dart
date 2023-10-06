import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/screen/detail_restaurant_screen.dart';
import 'package:restaurant_app/screen/list_restaurant_screen.dart';
import 'package:restaurant_app/screen/search_restaurant_screen.dart';
import 'package:restaurant_app/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
            appBarTheme: const AppBarTheme(elevation: 0),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))))),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  onPrimary: Colors.black,
                  secondary: secondaryColor,
                )),
        initialRoute: ListRestaurantScreen.routeName,
        routes: {
          ListRestaurantScreen.routeName: (context) =>
              const ListRestaurantScreen(),
          DetailRestaurantScreen.routeName: (context) => DetailRestaurantScreen(
                restaurantId:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchScreen.routeName: (context) => const SearchScreen()
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/screens/favorites_screen.dart';

import './models/dummy-data.dart';
import './models/meal.dart';
import './screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './screens/error_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "isGlutenFreeOn": false,
    "isLactoseFreeOn": false,
    "isVeganOn": false,
    "isVegetarianOn": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        // if glutenFree switch is on and the current meal is
        // not gluten free then exclude the meal from the list
        if (_filters["isGlutenFreeOn"] && !meal.isGlutenFree) return false;

        // if lactoseFree switch is on and the current meal is
        // not lactose free then exclude the meal from the list
        if (_filters["isLactoseFreeOn"] && !meal.isLactoseFree) return false;

        // if vegan switch is on and the current meal is
        // not vegan then exclude the meal from the list
        if (_filters["isVeganOn"] && !meal.isVegan) return false;

        // if vegetarian switch is on and the current meal is
        // not vegetarian then exclude the meal from the list
        if (_filters["isVegetarianOn"] && !meal.isVegetarian) return false;

        // only return true i.e include the meal in the list only
        // if the meal does not fall in any of the above cases
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );

    if (existingIndex >= 0) {
      setState(
        () {
          _favoriteMeals.removeAt(existingIndex);
        },
      );
    } else {
      setState(
        () {
          _favoriteMeals.add(
            DUMMY_MEALS.firstWhere(
              (meal) => meal.id == mealId,
            ),
          );
        },
      );
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any(
      (meal) => meal.id == mealId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orange,
        brightness: Brightness.dark,
        //canvasColor: Color.fromRGBO(230, 230, 230, 1.0),
        fontFamily: "OpenSans",
        textTheme: ThemeData.dark().textTheme.copyWith(
              body1: TextStyle(
                color: Colors.white,
              ),
              body2: TextStyle(
                color: Colors.white,
              ),
              title: TextStyle(
                fontFamily: "RopaSans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      routes: {
        "/": (ctx) => TabsScreen(
              _favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              _isMealFavorite,
              _toggleFavorite,
            ),
        SettingsScreen.routeName: (ctx) => SettingsScreen(
              _filters,
              _setFilters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => ErrorScreen(),
        );
      },
    );
  }
}

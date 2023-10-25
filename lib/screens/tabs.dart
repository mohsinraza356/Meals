import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex=0;
  final List<Meal> _favouriteMeals=[];

  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting=_favouriteMeals.contains(meal);
    if(isExisting){
      _favouriteMeals.remove(meal);
    }
    else{
      _favouriteMeals.add(meal);
    }
  }
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget activePage=  CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus,);
    var activePageTitle='Categories';
    if (_selectedPageIndex==1){
      activePage=MealsScreen(meals: _favouriteMeals,onToggleFavorite: _toggleMealFavoriteStatus,);
      activePageTitle='Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label:'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label:'Favorites'),
        ],
        onTap: _selectPage
      ),
    );
  }
}

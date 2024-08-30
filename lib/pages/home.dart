import 'package:ad_foodz/components/descriptionBox.dart';
import 'package:ad_foodz/components/food_tile.dart';
import 'package:ad_foodz/components/location.dart';
import 'package:ad_foodz/components/my_drawer.dart';
import 'package:ad_foodz/components/my_silver_app_bar.dart';
import 'package:ad_foodz/components/tabBar.dart';
import 'package:ad_foodz/models/food.dart';
import 'package:ad_foodz/models/resturant.dart';
import 'package:ad_foodz/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out and return a list of food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map(
      (category) {
        //get catogory menu
        List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

        return ListView.builder(
          itemCount: categoryMenu.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            // get individual food
            final food = categoryMenu[index];

            // return food tile UI
            return FoodTile(
              food: food,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(food: food),
                ),
              ),
            );
          },
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // current location
                const MyCurrentLocation(),

                // description box
                const MyDescriptionBox(),
              ],
            ),
          )
        ],
        body: Consumer<Resturant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurant.menu),
          ),
        ),
      ),
    );
  }
}

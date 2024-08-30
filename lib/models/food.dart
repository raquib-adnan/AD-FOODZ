// food item
class Food {
  final String name; //dosa
  final String description; //Indian breakfast
  final String imagePath; //images
  final double price; // 65.00
  final FoodCategory category; //veg
  List<Addon> availableAddons; //chattni and sambaar

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

//food categories
enum FoodCategory {
  veg,
  nonveg,
  snacks,
  // desserts,
  drinks,
}

// food addons
class Addon {
  String name;
  double price;

  Addon({required this.name, required this.price});
}

import 'package:ad_foodz/models/cart_items.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'food.dart';

class Resturant extends ChangeNotifier {
  //list of food menu
  final List<Food> _menu = [
    //                                   veg
    Food(
      name: "IDLI",
      description:
          "Its an Indian Breakfast. Its is basically a type of Rice cake made up of rice flour",
      imagePath: "lib/assets/veg/idli.jpeg",
      price: 30.00,
      category: FoodCategory.veg,
      availableAddons: [
        Addon(name: " extra sambaar", price: 20.00),
      ],
    ),
    Food(
      name: "DOSA",
      description: "Madeup of Rice batter",
      imagePath: "lib/assets/veg/dosa.jpg",
      price: 40.00,
      category: FoodCategory.veg,
      availableAddons: [
        Addon(name: "extra sambaar", price: 20.00),
      ],
    ),
    Food(
      name: "MASALA DOSA",
      description: "Its an Indian Breakfast.",
      imagePath: "lib/assets/veg/masala_dosa.jpg",
      price: 80.00,
      category: FoodCategory.veg,
      availableAddons: [
        Addon(name: " extra sambaar", price: 20.00),
      ],
    ),
    Food(
      name: "POORI",
      description: "Its an Indian Breakfast",
      imagePath: "lib/assets/veg/poori.jpeg",
      price: 40.00,
      category: FoodCategory.veg,
      availableAddons: [
        Addon(name: "extra CHUTNI", price: 20.00),
      ],
    ),

    //                                 non veg
    Food(
      name: "CHIKEN ROLL",
      description: "Its an non-veg roll",
      imagePath: "lib/assets/nonveg/chiken.jpg",
      price: 60.00,
      category: FoodCategory.nonveg,
      availableAddons: [
        Addon(name: "extra mayo", price: 10.00),
      ],
    ),
    Food(
      name: "Mutton Roll",
      description: "Its an non-veg roll",
      imagePath: "lib/assets/nonveg/mutton.jpg",
      price: 80.00,
      category: FoodCategory.nonveg,
      availableAddons: [
        Addon(name: "extra mayo", price: 10.00),
      ],
    ),
    Food(
      name: "PAAYA-ROTI",
      description: "Its an non-veg roll",
      imagePath: "lib/assets/nonveg/paaya_roti.jpeg",
      price: 100.00,
      category: FoodCategory.nonveg,
      availableAddons: [
        Addon(name: "extra mayo", price: 10.00),
      ],
    ),
    Food(
      name: "SHEEK-ROLL",
      description: "Its an non-veg roll",
      imagePath: "lib/assets/nonveg/sheek_roll.jpeg",
      price: 90.00,
      category: FoodCategory.nonveg,
      availableAddons: [
        Addon(name: "extra mayo", price: 10.00),
      ],
    ),

    //                                 snacks
    Food(
      name: "FRIES",
      description: "snacks",
      imagePath: "lib/assets/snacks/fries.jpeg",
      price: 50.00,
      category: FoodCategory.snacks,
      availableAddons: [
        Addon(name: "extra ketchup", price: 10.00),
      ],
    ),
    Food(
      name: "PERI-PERI FRIES",
      description: "snacks",
      imagePath: "lib/assets/snacks/periperi.jpeg",
      price: 60.00,
      category: FoodCategory.snacks,
      availableAddons: [
        Addon(name: "extra ketchup", price: 10.00),
      ],
    ),
    Food(
      name: "CHIKEN LOADED",
      description: "snacks",
      imagePath: "lib/assets/snacks/loaded.jpeg",
      price: 100.00,
      category: FoodCategory.snacks,
      availableAddons: [
        Addon(name: "extra mayo", price: 10.00),
      ],
    ),
    Food(
      name: "SMILY FRIES",
      description: "snacks",
      imagePath: "lib/assets/snacks/smiles.jpeg",
      price: 60.00,
      category: FoodCategory.snacks,
      availableAddons: [
        Addon(name: "extra ketchup", price: 10.00),
      ],
    ),

    //                                 drinks
    Food(
      name: "MANGO",
      description: "DRINK",
      imagePath: "lib/assets/drinks/mango.jpeg",
      price: 70.00,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "SUGAR FREE", price: 30.00),
      ],
    ),
    Food(
      name: "ORANGE",
      description: "DRINK",
      imagePath: "lib/assets/drinks/orange_juice.jpeg",
      price: 50.00,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "SUGAR FREE", price: 30.00),
      ],
    ),
    Food(
      name: "STRAWBERRY",
      description: "DRINK",
      imagePath: "lib/assets/drinks/strawberry_juice.jpeg",
      price: 55.00,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "SUGAR FREE", price: 30.00),
      ],
    ),
    Food(
      name: "WATERMELON",
      description: "DRINK",
      imagePath: "lib/assets/drinks/watermelon.jpeg",
      price: 40.00,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "SUGAR FREE", price: 30.00),
      ],
    ),
  ];

  /*
    G E T T E R S
  */

  List<Food> get menu => _menu;
  List<CartItems> get cart => _cart;

  /*
   O P E R A T I O N S 
  */

  //user cart
  List<CartItems> _cart = [];

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    //see if there is a cart item already with the same food and selected addons
    CartItems? cartItems = _cart.firstWhereOrNull((item) {
      //check if the ffood items are the same
      bool isSameFood = item.food == food;

      //check if the list of selected addons are the same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    //if item already exists, increase the quantity
    if (cartItems != null) {
      cartItems.quantity++;
    }

    // otherwise, add a new cart item to the cart
    else {
      _cart.add(
        CartItems(food: food, selectedAddons: selectedAddons),
      );
    }
    notifyListeners();
  }

  // remove from cart
  void removeFormCart(CartItems cartItems) {
    int cartIndex = _cart.indexOf(cartItems);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItems cartItems in _cart) {
      double itemTotal = cartItems.food.price;

      for (Addon addon in cartItems.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItems.quantity;
    }
    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItems cartItems in _cart) {
      totalItemCount += cartItems.quantity;
    }

    return totalItemCount;
  }

  //clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /*
  H E L P E R S
  */
  // generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your reciept.");
    receipt.writeln();

    //format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final CartItems in _cart) {
      receipt.writeln(
          "${CartItems.quantity} x ${CartItems.food.name} - ${_formatPrice(CartItems.food.price)}");
      if (CartItems.selectedAddons.isNotEmpty) {
        receipt
            .writeln("  Add-ons: ${_formatAddons(CartItems.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("----------");
    receipt.writeln("");
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    return "\₹${price.toStringAsFixed(2)}";
  }

  // format list of adddons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}

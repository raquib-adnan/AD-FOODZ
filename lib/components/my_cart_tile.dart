import 'package:ad_foodz/components/quantity_selector.dart';
import 'package:ad_foodz/models/cart_items.dart';
import 'package:ad_foodz/models/resturant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItems cartItems;

  const MyCartTile({super.key, required this.cartItems});

  get label => null;

  @override
  Widget build(BuildContext context) {
    return Consumer<Resturant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItems.food.imagePath,
                      height: 100,
                      width: 100,
                    ),
                  ),

                  const SizedBox(width: 10),

                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //food name
                      Text(cartItems.food.name),

                      //food price
                      Text(
                        '\₹' + cartItems.food.price.toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),

                  const Spacer(),

                  //increment and decrementt quantity
                  QuantitySelector(
                      quantity: cartItems.quantity,
                      food: cartItems.food,
                      onDecrement: () {
                        restaurant.removeFormCart(cartItems);
                      },
                      onIncrement: () {
                        restaurant.addToCart(
                            cartItems.food, cartItems.selectedAddons);
                      })
                ],
              ),
            ),

            //addons
            SizedBox(
              height: cartItems.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                children: cartItems.selectedAddons
                    .map(
                      (addon) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Row(
                            children: [
                              //addon name
                              Text(addon.name),

                              //addon price
                              Text(' (\$${addon.price})'),
                            ],
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          onSelected: (value) {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

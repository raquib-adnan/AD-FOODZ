import 'package:ad_foodz/components/my_button.dart';
import 'package:ad_foodz/components/my_cart_tile.dart';
import 'package:ad_foodz/models/resturant.dart';
import 'package:ad_foodz/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Resturant>(
      builder: (context, restaurant, child) {
        //cart
        final userCart = restaurant.cart;

        //scaffold UI
        return Scaffold(
          appBar: AppBar(
            title: Text("cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              //clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to clear the cart?"),
                      actions: [
                        //cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),

                        //yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
          body: Column(
            children: [
              //list to cart
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text("cart is Empty.."),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                // get individual cart item
                                final CartItems = userCart[index];

                                //return cart tile UI
                                return MyCartTile(cartItems: CartItems);
                              },
                            ),
                          ),
                  ],
                ),
              ),

              //button to pay
              MyButton(
                text: "Go to Checkout",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}

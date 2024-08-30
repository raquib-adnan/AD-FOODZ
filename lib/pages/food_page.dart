import 'package:ad_foodz/components/my_button.dart';
import 'package:ad_foodz/models/food.dart';
import 'package:ad_foodz/models/resturant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddon = {};

  FoodPage({
    super.key,
    required this.food,
  }) {
    // initialize sleected addons to be false
    for (Addon addon in food.availableAddons) {
      selectedAddon[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  //method to add to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    //close teh current food pae to go back to menu
    Navigator.pop(context);

    //format the selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddon[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    //add to cart
    context.read<Resturant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //scaffold UI
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // food image
                Image.asset(widget.food.imagePath),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //food name
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),

                      //food price
                      Text(
                        '\₹' + widget.food.price.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary),
                      ),

                      const SizedBox(height: 10),

                      //food description
                      Text(widget.food.description),

                      const SizedBox(height: 25),

                      Divider(color: Colors.black),

                      const SizedBox(height: 10),
                      //addon
                      Text(
                        "Add-ons",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            // get individual adddon
                            Addon addon = widget.food.availableAddons[index];

                            //return checkbox ui
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                '\₹${addon.price}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              value: widget.selectedAddon[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddon[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                //button for adding to cart
                MyButton(
                  text: "Add to Cart",
                  onTap: () => addToCart(widget.food, widget.selectedAddon),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
        //back button
        SafeArea(
          child: Opacity(
            opacity: 0.9,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        )
      ],
    );
  }
}

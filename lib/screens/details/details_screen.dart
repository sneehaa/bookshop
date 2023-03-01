import 'package:bookshop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../favorites/favorites.dart';


class DetailsScreen extends StatelessWidget {
   DetailsScreen({Key? key, required this.product, required this.onAddToFavorites}) : super(key: key);

  final Product product;
   final Function(String) onAddToFavorites;

  final List<Product> _cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.bgColor,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              onAddToFavorites(product.title);
              Navigator.pop(context, product.title);
            },
            icon: Icon(Icons.favorite_border_outlined, color: Colors.black,),
          )
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            product.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        "\$" + product.price.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Text(
                     "You're never alone, if you're a reader"
                    ),
                  ),

                  const SizedBox(height: defaultPadding * 2),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                  cartItems: _cartItems + [product]
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Add to Cart"),
                      ),

                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

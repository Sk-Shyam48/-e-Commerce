import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commece/Screens/CartPage.dart';
import 'package:e_commece/models/product_model.dart';
import 'package:e_commece/Secondpage_widgets/ProductInfo.dart';
import 'package:e_commece/Secondpage_widgets/ProductCarousel.dart';
import 'package:e_commece/Secondpage_widgets/SizeOptions.dart';
import 'package:e_commece/models/cart_item.dart';

class SecondPage extends StatefulWidget {
  final Product product;

  const SecondPage({super.key, required this.product});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<CartItem> cartItems = [];
  int? selectedSize;

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  void loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsString = prefs.getStringList('cartItems');
    if (cartItemsString != null) {
      setState(() {
        cartItems = cartItemsString
            .map((itemString) => CartItem.fromJson(jsonDecode(itemString)))
            .toList();
      });
    }
  }

  void addToCart() async {
    if (selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size')),
      );
      return;
    }
    bool isAlreadyInCart = cartItems.any((item) =>
        item.name == widget.product.title &&
        item.size == selectedSize.toString());

    if (isAlreadyInCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This product is already in the cart')),
      );
      return;
    }
    setState(() {
      cartItems.insert(
        0,
        CartItem(
          name: widget.product.title,
          size: selectedSize.toString(),
          price: widget.product.price,
          imagePath: widget.product.image,
        ),
      );
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsString =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList('cartItems', cartItemsString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductCarousel(productImage: widget.product.image),
            ProductInfo(product: widget.product),
            const SizedBox(height: 40),
            SizeOptions(
              sizes: const [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45],
              onSizeSelected: (selectedSize) {
                setState(() {
                  this.selectedSize = selectedSize;
                });
              },
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 40),
              child: TextButton(
                onPressed: () {
                  addToCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(cartItems: cartItems),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(239, 104, 44, 1),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:e_commece/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
  }

  void _saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsString =
        _cartItems.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList('cartItems', cartItemsString);
  }

  void _updateQuantity(CartItem item, int change) {
    setState(() {
      item.quantity += change;
      if (item.quantity < 1) {
        _cartItems.remove(item);
      }
    });
    _saveCartItems();
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(248, 248, 248, 1),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 70,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(249, 235, 226, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  item.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Size: ${item.size}',
                  style: const TextStyle(fontSize: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          color: const Color.fromRGBO(239, 104, 44, 1),
                          onPressed: () {
                            _updateQuantity(item, -1);
                          },
                        ),
                        Text(
                          "${item.quantity}",
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          color: const Color.fromRGBO(239, 104, 44, 1),
                          onPressed: () {
                            _updateQuantity(item, 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        _cartItems.fold(0, (total, item) => total + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("My Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: _cartItems.map((item) => _buildCartItem(item)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(239, 104, 44, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(239, 104, 44, 1),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Buy Now',
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
    );
  }
}

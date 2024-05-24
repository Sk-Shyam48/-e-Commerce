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
  final List<Color> _backgroundColors = [
    const Color.fromRGBO(249, 235, 226, 1),
    const Color.fromRGBO(232, 243, 248, 1),
    const Color.fromRGBO(238, 223, 224, 1),
    const Color.fromRGBO(227, 229, 233, 1)
  ];

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
  }

  Future<void> _saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsString =
        _cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cartItems', cartItemsString);
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

// _buildCartItem____________________________________
  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(248, 248, 248, 1),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCartItemImage(item, index),
          const SizedBox(width: 15),
          Expanded(
            child: _buildCartItemDetails(item),
          ),
        ],
      ),
    );
  }

//  _buildCartItemImage__________________________________
  Widget _buildCartItemImage(CartItem item, int index) {
    return Container(
      width: 70,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _backgroundColors[index % _backgroundColors.length],
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
    );
  }

//  _buildCartItemDetails_________________________
  Widget _buildCartItemDetails(CartItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
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
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Row(
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
            ),
          ],
        ),
      ],
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
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(_cartItems[index], index);
              },
            ),
          ),
          _buildTotalPrice(totalPrice),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

// _buildTotalPrice_____________________________
  Widget _buildTotalPrice(double totalPrice) {
    return Padding(
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
    );
  }

// _buildBottomBar__________________
  Widget _buildBottomBar() {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }
}

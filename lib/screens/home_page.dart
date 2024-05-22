import 'dart:convert';

import 'package:e_commece/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:e_commece/models/product_model.dart';
import 'package:e_commece/Screens/Product_view_page.dart';
import 'package:e_commece/Screens/CartPage.dart';
import 'package:e_commece/Screens/FavoritePage.dart';
import 'package:e_commece/Screens/ProfilePage.dart';
import 'package:e_commece/Homepage_widgets/ProductCard.dart';
import 'package:e_commece/Homepage_widgets/PromoCard.dart';
import 'package:e_commece/Homepage_widgets/TopCategories.dart';
import 'package:e_commece/Homepage_widgets/BottomNavBar.dart';
import 'package:e_commece/Services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await ProductService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  Future<List<CartItem>> loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsString = prefs.getStringList('cartItems');
    if (cartItemsString != null) {
      return cartItemsString
          .map((itemString) => CartItem.fromJson(jsonDecode(itemString)))
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(248, 248, 248, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.keyboard_command_key),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(248, 248, 248, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Hello Rocky 😘',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Let\'s get something?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                children: const [
                  PromoCard(
                    text: '30% OFF During COVID 19',
                    color: Color.fromRGBO(239, 104, 44, 1),
                    imagePath: 'assets/slide1.png',
                  ),
                  SizedBox(width: 20),
                  PromoCard(
                    text: '30% OFF During COVID 19',
                    color: Color.fromRGBO(16, 132, 245, 1),
                    imagePath: 'assets/slide1.png',
                  ),
                  SizedBox(width: 20),
                  PromoCard(
                    text: '30% OFF During COVID 19',
                    color: Colors.red,
                    imagePath: 'assets/slide1.png',
                  ),
                  SizedBox(width: 20),
                  PromoCard(
                    text: '30% OFF During COVID 19',
                    color: Colors.green,
                    imagePath: 'assets/slide1.png',
                  ),
                ],
              ),
            ),
            TopCategories(iconDataList: _iconDataList),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
                children: _products.map((product) {
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(product: product),
                        ),
                      );
                    },
                    discount: '30% OFF',
                    originalPrice: '\$200',
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _bottomNavIndex,
        onTabChange: (index) async {
          setState(() {
            _bottomNavIndex = index;
          });

          switch (index) {
            case 0: // Home tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
              break;
            case 1: // Favorite tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
              break;
            case 2: // Cart tab

              List<CartItem> cartItems = await loadCartItems();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
              break;
            case 3: // Profile tab
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }

  final List<IconData> _iconDataList = [
    Icons.watch,
    Icons.shop,
    Icons.sports,
    Icons.home,
    Icons.settings,
    Icons.notifications,
    Icons.mail,
    Icons.person,
    Icons.camera,
    Icons.music_note,
    Icons.ac_unit_sharp
  ];
}

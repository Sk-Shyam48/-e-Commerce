import 'package:flutter/material.dart';
import 'SecondPage.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:e_commece/models/product_model.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      setState(() {
        _products = productJson.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.keyboard_command_key,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 30, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello Rocky 😘',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Let\'s get something?',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              children: [
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: const Color.fromRGBO(239, 104, 44, 1),
                  imagePath: 'assets/slide1.png',
                ),
                const SizedBox(width: 20),
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: const Color.fromRGBO(16, 132, 245, 1),
                  imagePath: 'assets/slide1.png',
                ),
                const SizedBox(width: 20),
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: Colors.red,
                  imagePath: 'assets/slide1.png',
                ),
                const SizedBox(width: 20),
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: Colors.green,
                  imagePath: 'assets/slide1.png',
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    color: Color.fromRGBO(239, 104, 44, 1),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var iconData in _iconDataList) ...[
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(239, 104, 44, 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(iconData, color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75,
                  children: _products.map((product) {
                    return _buildProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondPage(),
                          ),
                        );
                      },
                      discount: '30% OFF',
                      originalPrice: '\$200',
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CubertoBottomBar(
        inactiveIconColor: Colors.grey,
        selectedTab: _bottomNavIndex,
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "Home",
          ),
          TabData(
            iconData: Icons.favorite,
            title: "Favorite",
          ),
          TabData(
            iconData: Icons.shopping_cart,
            title: "Cart",
          ),
          TabData(
            iconData: Icons.person,
            title: "Profile",
          ),
        ],
        onTabChangedListener: (position, title, color) {
          setState(() {
            _bottomNavIndex = position;
          });
        },
      ),
    );
  }

// ________ _buildPromoCard_______________
  Widget _buildPromoCard({
    required String text,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      width: 350,
      height: 100,
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Get Now',
                    style: TextStyle(color: color),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            imagePath,
            width: 120,
            height: 120,
          ),
        ],
      ),
    );
  }

// _buildProductCard________________________

  Widget _buildProductCard({
    required Product product,
    required VoidCallback onTap,
    required String discount,
    required String originalPrice,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(248, 248, 248, 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.favorite_outlined,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.network(
                product.image,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

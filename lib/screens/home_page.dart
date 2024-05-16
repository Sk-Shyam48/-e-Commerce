import 'package:flutter/material.dart';
import 'SecondPage.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;

  final List<IconData> iconDataList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
          // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              Icons.keyboard_command_key,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
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
          Container(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              children: [
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: Color.fromRGBO(239, 104, 44, 1),
                  imagePath: 'assets/slide1.png',
                ),
                SizedBox(width: 20),
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: Color.fromRGBO(16, 132, 245, 1),
                  imagePath: 'assets/slide1.png',
                ),
                SizedBox(width: 20),
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: Colors.red,
                  imagePath: 'assets/slide1.png',
                ),
                SizedBox(width: 20),
                _buildPromoCard(
                  text: '30% OFF During COVID 19',
                  color: Colors.green,
                  imagePath: 'assets/slide1.png',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
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
          Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var iconData in _iconDataList) ...[
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(239, 104, 44, 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(iconData, color: Colors.white),
                  ),
                  // SizedBox(width: ),
                ],
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75,
                  children: [
                    _buildProductCard(
                      title: 'Apple Watch Series 6',
                      price: '\$140',
                      originalPrice: '\$200',
                      imagePath: 'assets/Apple Watch -M2.png',
                      discount: '30% OFF',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage()),
                        );
                      },
                    ),
                    _buildProductCard(
                      title: 'Apple Watch Series 6',
                      price: '\$100',
                      originalPrice: '\$250',
                      imagePath: 'assets/p1.png',
                      discount: '30% OFF',
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SecondPage()),
                        // );
                      },
                    ),
                    _buildProductCard(
                      title: 'Apple Watch Series 6',
                      price: '\$140',
                      originalPrice: '\$200',
                      imagePath: 'assets/image-1.png',
                      discount: '30% OFF',
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SecondPage()),
                        // );
                      },
                    ),
                    _buildProductCard(
                      title: 'Apple Watch Series 6',
                      price: '\$100',
                      originalPrice: '\$200',
                      imagePath: 'assets/p2.png',
                      discount: '30% OFF',
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SecondPage()),
                        // );
                      },
                    ),
                  ],
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

  Widget _buildPromoCard({
    required String text,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      width: 350,
      height: 150,
      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }

// _buildProductCard________________________

  Widget _buildProductCard({
    // required BuildContext context,
    required String title,
    required String price,
    required String originalPrice,
    required String imagePath,
    required String discount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 43, 5, 0),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    discount,
                    style: TextStyle(
                      color: Colors.white,
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
            SizedBox(height: 10),
            Center(
              child: Image.asset(
                imagePath,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        originalPrice,
                        style: TextStyle(
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
  ];
}

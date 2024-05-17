import 'package:flutter/material.dart';

class CartItem {
  String name;
  String size;
  double price;
  String imagePath;

  CartItem(
      {required this.name,
      required this.size,
      required this.price,
      required this.imagePath});
}

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color.fromRGBO(248, 248, 248, 1),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 70,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(249, 235, 226, 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item.size,
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "\$${item.price.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            color: Color.fromRGBO(239, 104, 44, 1),
                            onPressed: () {},
                          ),
                          Text(
                            "1",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            color: Color.fromRGBO(239, 104, 44, 1),
                            onPressed: () {},
                          ),
                        ],
                      ),
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
    List<CartItem> items = [
      CartItem(
          name: "Apple Watch series 6",
          size: "Size 36",
          price: 140,
          imagePath: 'assets/Apple Watch -M2.png'),
      CartItem(
          name: "Sony ear headphone",
          size: "Size 36",
          price: 50,
          imagePath: 'assets/Ear Headphone.png'),
      CartItem(
          name: "Apple Watch series 6",
          size: "Size 36",
          price: 140,
          imagePath: 'assets/White Tshirt.png'),
      CartItem(
          name: "Apple Watch series 6",
          size: "Size 36",
          price: 300,
          imagePath: 'assets/Nike Shoe.png'),
    ];

    double totalPrice = items.fold(0, (total, item) => total + item.price);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: items.map((item) => _buildCartItem(item)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$$totalPrice",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 30, 30, 60),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(239, 104, 44, 1),
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
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

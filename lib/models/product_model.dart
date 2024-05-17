class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  // Additional properties
  final String originalPrice;
  final String discount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    // Additional properties
    required this.originalPrice,
    required this.discount,
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],

      // Additional properties with default values
      originalPrice:
          json['originalPrice'] != null ? json['originalPrice'].toString() : '',

      discount: json['discount'] != null ? json['discount'] : '',
    );
  }
}

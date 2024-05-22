class CartItem {
  final String name;
  final String size;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.size,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      size: json['size'],
      price: json['price'],
      imagePath: json['imagePath'],
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size,
      'price': price,
      'imagePath': imagePath,
      'quantity': quantity,
    };
  }
}

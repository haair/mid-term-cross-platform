class Product {
  final String id;
  final String name;
  final String type;
  final String price;
  final String image;

  const Product(
      {required this.id,
      required this.name,
      required this.type,
      required this.price,
      required this.image});

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      price: data['price'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

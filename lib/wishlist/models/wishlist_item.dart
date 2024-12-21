class WishlistItem {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String image;
  final String slug;

  WishlistItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    required this.slug,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: double.parse(json['price'].toString()),
      image: json['image'],
      slug: json['slug'],
    );
  }
}

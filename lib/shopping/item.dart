class Item {
  Item({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.amount = 0,
  });

  final String name;
  final double price;
  final String imageUrl;
  int amount;
}

class Item {
  Item({
    required this.name,
    required this.price,
    this.amount = 0,
  });

  final String name;
  final double price;
  int amount;
}

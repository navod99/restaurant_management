class Item {
  final num itemId;
  final String name;
  final int price;
  int quantity = 1;

  Item(
      {required this.itemId, required this.name, required this.price, required this.quantity});

}

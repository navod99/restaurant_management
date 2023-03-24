class Item {
  final num id;
  final String name;
  final int price;
  int quantity = 1;

  Item(
      {required this.id, required this.name, required this.price, required this.quantity});

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'price': price,
  //     };

  // factory Item.fromJson(Map<String, dynamic> json) =>
  //     Item(name: json['name'], price: json['price']);

}

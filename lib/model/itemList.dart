class Item {
  final num id;
  final String name;
  final double price;

  Item(
      {required this.id, required this.name, required this.price});

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'price': price,
  //     };

  // factory Item.fromJson(Map<String, dynamic> json) =>
  //     Item(name: json['name'], price: json['price']);

}

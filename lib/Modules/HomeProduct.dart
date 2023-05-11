class Product {
  // double?  oldPrice;
  num ?discount,price,oldPrice;
  String? imageUrl, name;

  Product({this.price, this.oldPrice, this.discount, this.imageUrl, this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        discount:  json['discount'],
        price: json['price'],
        oldPrice: json['old_price'],
        imageUrl: json['image']);
  }
}

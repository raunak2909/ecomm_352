class CartModel{
  int? id;
  int? product_id;
  int? quantity;
  String? price;
  String? name;
  String? image;

  CartModel({
    this.id,
    this.product_id,
    this.quantity,
    this.price,
    this.name,
    this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    product_id: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    name: json["name"],
    image: json["image"],
  );


}
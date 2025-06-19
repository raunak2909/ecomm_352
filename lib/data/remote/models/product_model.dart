class ProductModel{
  String? category_id;
  String? created_at;
  String? id;
  String? image;
  String? name;
  String? price;
  String? status;
  String? updated_at;

  ProductModel({
    this.category_id,
    this.created_at,
    this.id,
    this.image,
    this.name,
    this.price,
    this.status,
    this.updated_at,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    category_id: json['category_id'],
    created_at: json['created_at'],
    id: json['id'],
    image: json['image'],
    name: json['name'],
    price: json['price'],
    status: json['status'],
    updated_at: json['updated_at'],
  );

}

class ProductDataModel{
  String? message;
  bool? status;
  List<ProductModel>? data;

  ProductDataModel({
    this.message,
    this.status,
    required this.data,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
    message: json['message'],
    status: json['status'],
    data: List<ProductModel>.from(json['data'].map((e) => ProductModel.fromJson(e))),
  );
}
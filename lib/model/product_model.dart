// To parse this JSON data, do
//
//     final productData = productDataFromJson(jsonString);

import 'dart:convert';

ProductData productDataFromJson(String str) => ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductData({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? discountPrice;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;
  int? quantity;
  bool? checkFavourite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
    this.quantity,
    this.discountPrice,
    this.checkFavourite,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    checkFavourite: false,
    quantity: 1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "quantity":1,
    "checkFavourite": false,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}
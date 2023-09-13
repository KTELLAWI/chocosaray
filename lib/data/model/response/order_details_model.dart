import 'package:chocsarayi/data/model/response/product_model.dart';

class OrderDetailsModel {
  int _productId;
  int _orderId;
  double _price;
  Product _productDetails;
  int _quantity;
  String _createdAt;
  String _updatedAt;
  List<int> _addOnIds;


  OrderDetailsModel(
      {
        int productId,
        int orderId,
        double price,
        Product productDetails,
        int quantity,
        String createdAt,
        String updatedAt,
        List<int> addOnIds,
       }) {

    this._productId = productId;
    this._orderId = orderId;
    this._price = price;
    this._productDetails = productDetails;
    this._quantity = quantity;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._addOnIds = addOnIds;

  }

  int get productId => _productId;
  int get orderId => _orderId;
  double get price => _price;
  Product get productDetails => _productDetails;
  int get quantity => _quantity;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<int> get addOnIds => _addOnIds;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _orderId = json['order_id'];
    _price = json['price'].toDouble();
    _quantity = json['quantity'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _addOnIds = json['add_on_ids'].cast<int>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this._productId;
    data['order_id'] = this._orderId;
    data['price'] = this._price;
    data['quantity'] = this._quantity;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['add_on_ids'] = this._addOnIds;
    return data;
  }
}
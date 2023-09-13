import 'package:chocsarayi/data/model/response/product_model.dart';

class CartModel {
  int _quantity;
  Product _product;
  double _price;
  CartModel(
        int quantity,
        Product product,
      double price) {
    this._quantity = quantity;
    this._product = product;
    this._price = price;
  }


  // ignore: unnecessary_getters_setters
  int get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int qty) => _quantity = qty;
  set price(double price) => _price = price;
  Product get product => _product;
  double get price => _price;

}

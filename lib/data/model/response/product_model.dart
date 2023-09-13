class ProductModel {
  int _totalSize;
  String _limit;
  String _offset;
  List<Product> _products;

  ProductModel(
      {int totalSize, String limit, String offset, List<Product> products}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._products = products;
  }

  int get totalSize => _totalSize;
  String get limit => _limit;
  String get offset => _offset;
  List<Product> get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];

    }
  }


}

class Product {
  int _id;
  String _name;
  String _description;
  String _image;
  String _category;
  String _type;
  double _price;
  List<Rating> _rating;
  List _addson;

  Product(
      {int id,
        String name,
        String description,
        String image,
        String category,
        String type,
        double price,
        List addson,
        List<Rating> rating}) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._image = image;
    this._price = price;
    this._type = type;
    this._rating = rating;
    this._addson=addson;
    this._category=category;
  }

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get image => _image;
  String get type => _type;
  String get category => _category;
  double get price => _price;
  List<Rating> get rating => _rating;
  List get addson => _addson;
}

class Rating {
  String _average;
  int _productId;

  Rating({String average, int productId}) {
    this._average = average;
    this._productId = productId;
  }

  String get average => _average;
  int get productId => _productId;

}
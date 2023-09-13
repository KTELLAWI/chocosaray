import 'package:chocsarayi/data/model/response/product_model.dart';

class OrderModel {
  int _id;
  int _userId;
  String _orderAmount;
  String _orderStatus;
  int _deliveryAddressId;
  String _createdAt;
  String _updatedAt;
  String _orderNote;
  String _count;

  OrderModel(
      {int id,
        int userId,
        String orderAmount,
        String orderStatus,
        int deliveryAddressId,
        String createdAt,
        String updatedAt,
        String orderNote,
        String count,
}) {
    this._id = id;
    this._userId = userId;
    this._orderAmount = orderAmount;
    this._orderStatus = orderStatus;
    this._deliveryAddressId = deliveryAddressId;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._orderNote = orderNote;
    this._count = count;
  }

  int get id => _id;
  int get userId => _userId;
  String get orderAmount => _orderAmount;
  String get orderStatus => _orderStatus;

  int get deliveryAddressId => _deliveryAddressId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get orderNote => _orderNote;
  String get count => _count;
  OrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _orderAmount = json['order_amount'].toDouble();
    _orderStatus = json['order_status'];
    _deliveryAddressId = json['delivery_address_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];

    _orderNote = json['order_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['order_amount'] = this._orderAmount;
    data['order_status'] = this._orderStatus;
    data['delivery_address_id'] = this._deliveryAddressId;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['order_note'] = this._orderNote;
    return data;
  }
}


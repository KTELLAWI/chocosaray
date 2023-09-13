class CategoryModel {
  int _id;
  String _image;
  String _name;
  CategoryModel(
      {int id,
        String name,
        String image}) {
    this._id = id;
    this._name = name;
    this._image = image;
  }
  int get id => _id;
  String get name => _name;
  String get image => _image;

}

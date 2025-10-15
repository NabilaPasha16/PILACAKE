import 'cake_category.dart';

// Encapsulation: gunakan private field dan public getter/setter
class Cake {
  String _name;
  double _price;
  String _imagePath;
  String _description;
  CakeCategory? _category;

  Cake(this._name, this._price, this._imagePath,
      {String description = "", CakeCategory? category})
      : _description = description,
        _category = category;

  // Getter & Setter (Encapsulation)
  String get name => _name;
  set name(String value) => _name = value;

  double get price => _price;
  set price(double value) => _price = value;

  String get imagePath => _imagePath;
  set imagePath(String value) => _imagePath = value;

  String get description => _description;
  set description(String value) => _description = value;

  CakeCategory? get category => _category;
  set category(CakeCategory? value) => _category = value;

  // Polymorphism: method yang bisa di-override
  String getCakeInfo() {
    String cat = _category != null ? " (${_category!.name})" : "";
    return "$_name$cat - Rp${_price.toStringAsFixed(0)}";
  }
}

// Inheritance: SpecialCake mewarisi Cake
class SpecialCake extends Cake {
  String _specialFeature;

  SpecialCake(String name, double price, String imagePath, this._specialFeature,
      {String description = "", CakeCategory? category})
      : super(name, price, imagePath, description: description, category: category);

  // Getter & Setter (Encapsulation)
  String get specialFeature => _specialFeature;
  set specialFeature(String value) => _specialFeature = value;

  // Polymorphism: override method
  @override
  String getCakeInfo() =>
      "$name (Spesial: $_specialFeature) - Rp${price.toStringAsFixed(0)}";
}

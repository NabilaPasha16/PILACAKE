// model/cake_category.dart
class CakeCategory {
  // Encapsulation: private fields
  String _id;
  String _name;
  String _description;
  String _assetImage;

  CakeCategory({
    required String id,
    required String name,
    required String description,
    required String assetImage,
  })  : _id = id,
        _name = name,
        _description = description,
        _assetImage = assetImage;

  // Getter & Setter (Encapsulation)
  String get id => _id;
  set id(String value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  String get description => _description;
  set description(String value) => _description = value;

  String get assetImage => _assetImage;
  set assetImage(String value) => _assetImage = value;

  // Polymorphism: method yang bisa di-override
  String getCategoryInfo() {
    return "$_name ($_description)";
  }
}

// Contoh inheritance & polymorphism
class SpecialCategory extends CakeCategory {
  String _specialNote;

  SpecialCategory({
    required String id,
    required String name,
    required String description,
    required String assetImage,
    required String specialNote,
  })  : _specialNote = specialNote,
        super(id: id, name: name, description: description, assetImage: assetImage);

  String get specialNote => _specialNote;
  set specialNote(String value) => _specialNote = value;

  @override
  String getCategoryInfo() {
    return "${super.name} ($_specialNote)";
  }
}

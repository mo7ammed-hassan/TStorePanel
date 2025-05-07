class ProductAttributesModel {
  final String name;
  final List<String> values;

  ProductAttributesModel({required this.name, required this.values});

  factory ProductAttributesModel.fromJson(Map<String, dynamic> json) {
    final rawValues = json['values'];

    final List<String> values =
        rawValues is List ? rawValues.map((e) => e.toString()).toList() : [];

    return ProductAttributesModel(name: json['name'] ?? '', values: values);
  }

  Map<String, dynamic> toJson() => {'name': name, 'values': values};
}

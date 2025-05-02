class ProductAttributesModel {
  final String name;
  final List<String>? values;

  ProductAttributesModel(this.name, this.values);

  ProductAttributesModel copyWith({String? name, List<String>? values}) =>
      ProductAttributesModel(name ?? this.name, values ?? this.values);

  Map<String, dynamic> toJson() => {'name': name, 'values': values};

  static ProductAttributesModel fromJson(Map<String, dynamic> json) =>
      ProductAttributesModel(json['name'], json['values'] ?? []);
}

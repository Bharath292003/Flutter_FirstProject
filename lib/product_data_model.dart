class ProductModel {
  final String ProductId;
  final String ProductName;
  final double Quantity;
  final bool IsActive;

  ProductModel(
      {required this.ProductId,
      required this.ProductName,
      required this.Quantity,
      required this.IsActive});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        ProductId: json['ProductId'] ?? '',
        ProductName: json['ProductName'] ?? '',
        Quantity: json['Quantity'],
        IsActive: json['IsActive']);
  }
}

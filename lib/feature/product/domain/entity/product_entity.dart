abstract class ProductEntity {
  ProductEntity({
    this.id,
    this.name,
    this.image,
    this.price,
    this.discount,
    this.type,
    this.favourite,
  });

  final String? id;
  final String? name;
  final String? image;
  final double? price;
  final double? discount;
  final String? type;
  final bool? favourite;
}

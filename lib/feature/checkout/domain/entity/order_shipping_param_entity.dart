class OrderShippingParamEntity {
  OrderShippingParamEntity({
    this.latitude,
    this.longitude,
    this.type,
  });

  final String? latitude;
  final String? longitude;
  final String? type;

  OrderShippingParamEntity copyWith({
    String? latitude,
    String? longitude,
    String? type,
  }) =>
      OrderShippingParamEntity(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        type: type ?? this.type,
      );
}

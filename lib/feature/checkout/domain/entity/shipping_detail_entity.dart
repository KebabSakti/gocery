class ShippingDetailEntity {
  ShippingDetailEntity({
    this.orderUid,
    this.partnerUid,
    this.uid,
    this.shipping,
    this.distance,
    this.distanceUnit,
    this.price,
    this.time,
  });

  final String? orderUid;
  final String? partnerUid;
  final String? uid;
  final String? shipping;
  final String? distance;
  final String? distanceUnit;
  final String? price;
  final String? time;

  ShippingDetailEntity copyWith({
    String? orderUid,
    String? partnerUid,
    String? uid,
    String? shipping,
    String? distance,
    String? distanceUnit,
    String? price,
    String? time,
  }) =>
      ShippingDetailEntity(
        orderUid: orderUid ?? this.orderUid,
        partnerUid: partnerUid ?? this.partnerUid,
        uid: uid ?? this.uid,
        shipping: shipping ?? this.shipping,
        distance: distance ?? this.distance,
        distanceUnit: distanceUnit ?? this.distanceUnit,
        price: price ?? this.price,
        time: time ?? this.time,
      );
}

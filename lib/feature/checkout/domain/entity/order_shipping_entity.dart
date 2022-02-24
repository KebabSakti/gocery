class OrderShippingEntity {
  OrderShippingEntity({
    this.uid,
    this.name,
    this.address,
    this.phone,
    this.shipping,
    this.type,
    this.latitude,
    this.longitude,
    this.online,
    this.distance,
    this.distanceUnit,
    this.price,
    this.time,
  });

  final String? uid;
  final String? name;
  final String? address;
  final String? phone;
  final String? shipping;
  final String? type;
  final String? latitude;
  final String? longitude;
  final int? online;
  final String? distance;
  final String? distanceUnit;
  final String? price;
  final String? time;

  OrderShippingEntity copyWith({
    String? uid,
    String? name,
    String? address,
    String? phone,
    String? shipping,
    String? type,
    String? latitude,
    String? longitude,
    int? online,
    String? distance,
    String? distanceUnit,
    String? price,
    String? time,
  }) =>
      OrderShippingEntity(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        shipping: shipping ?? this.shipping,
        type: type ?? this.type,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        online: online ?? this.online,
        distance: distance ?? this.distance,
        distanceUnit: distanceUnit ?? this.distanceUnit,
        price: price ?? this.price,
        time: time ?? this.time,
      );
}

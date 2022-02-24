class ShippingAddressEntity {
  ShippingAddressEntity({
    this.orderUid,
    this.uid,
    this.placeId,
    this.address,
    this.latitude,
    this.longitude,
    this.note,
    this.name,
    this.phone,
  });

  final String? orderUid;
  final String? uid;
  final String? placeId;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? note;
  final String? name;
  final String? phone;

  ShippingAddressEntity copyWith({
    String? orderUid,
    String? uid,
    String? placeId,
    String? address,
    String? latitude,
    String? longitude,
    String? note,
    String? name,
    String? phone,
  }) =>
      ShippingAddressEntity(
        orderUid: orderUid ?? this.orderUid,
        uid: uid ?? this.uid,
        placeId: placeId ?? this.placeId,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        note: note ?? this.note,
        name: name ?? this.name,
        phone: phone ?? this.phone,
      );
}

class PartnerEntity {
  PartnerEntity({
    this.uid,
    this.name,
    this.address,
    this.phone,
    this.shipping,
    this.type,
    this.latitude,
    this.longitude,
    this.online,
    this.exclusive,
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
  final int? exclusive;

  PartnerEntity copyWith({
    String? uid,
    String? name,
    String? address,
    String? phone,
    String? shipping,
    String? type,
    String? latitude,
    String? longitude,
    int? online,
    int? exclusive,
  }) =>
      PartnerEntity(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        shipping: shipping ?? this.shipping,
        type: type ?? this.type,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        online: online ?? this.online,
        exclusive: exclusive ?? this.exclusive,
      );
}

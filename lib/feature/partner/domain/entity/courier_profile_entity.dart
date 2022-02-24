class CourierProfileEntity {
  CourierProfileEntity({
    this.courierAccountUid,
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.picture,
  });

  final String? courierAccountUid;
  final String? uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? picture;

  CourierProfileEntity copyWith({
    String? courierAccountUid,
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? picture,
  }) =>
      CourierProfileEntity(
        courierAccountUid: courierAccountUid ?? this.courierAccountUid,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        picture: picture ?? this.picture,
      );
}

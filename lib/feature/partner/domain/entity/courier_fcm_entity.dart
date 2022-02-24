class CourierFcmEntity {
  CourierFcmEntity({
    this.courierAccountUid,
    this.uid,
    this.fcmToken,
  });

  final String? courierAccountUid;
  final String? uid;
  final String? fcmToken;

  CourierFcmEntity copyWith({
    String? courierAccountUid,
    String? uid,
    String? fcmToken,
  }) =>
      CourierFcmEntity(
        courierAccountUid: courierAccountUid ?? this.courierAccountUid,
        uid: uid ?? this.uid,
        fcmToken: fcmToken ?? this.fcmToken,
      );
}

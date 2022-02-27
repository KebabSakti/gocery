class ShippingTimeEntity {
  ShippingTimeEntity({
    this.uid,
    this.time,
    this.enable,
  });

  final String? uid;
  final String? time;
  final bool? enable;

  ShippingTimeEntity copyWith({
    String? uid,
    String? time,
    bool? enable,
  }) =>
      ShippingTimeEntity(
        uid: uid ?? this.uid,
        time: time ?? this.time,
        enable: enable ?? this.enable,
      );
}

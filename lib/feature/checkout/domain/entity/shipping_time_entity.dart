class ShippingTimeEntity {
  ShippingTimeEntity({
    this.uid,
    this.time,
    this.preparation,
    this.delivery,
    this.enable,
  });

  final String? uid;
  final String? time;
  final int? preparation;
  final String? delivery;
  final bool? enable;

  ShippingTimeEntity copyWith({
    String? uid,
    String? time,
    int? preparation,
    String? delivery,
    bool? enable,
  }) =>
      ShippingTimeEntity(
        uid: uid ?? this.uid,
        time: time ?? this.time,
        preparation: preparation ?? this.preparation,
        delivery: delivery ?? this.delivery,
        enable: enable ?? this.enable,
      );
}

class VoucherEntity {
  VoucherEntity({
    this.uid,
    this.title,
    this.description,
    this.image,
    this.max,
    this.amount,
    this.minOrder,
    this.startAt,
    this.expiredAt,
  });

  final String? uid;
  final String? title;
  final String? description;
  final String? image;
  final int? max;
  final String? amount;
  final String? minOrder;
  final String? startAt;
  final String? expiredAt;

  VoucherEntity copyWith({
    String? uid,
    String? title,
    String? description,
    String? image,
    int? max,
    String? amount,
    String? minOrder,
    String? startAt,
    String? expiredAt,
  }) =>
      VoucherEntity(
        uid: uid ?? this.uid,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        max: max ?? this.max,
        amount: amount ?? this.amount,
        minOrder: minOrder ?? this.minOrder,
        startAt: startAt ?? this.startAt,
        expiredAt: expiredAt ?? this.expiredAt,
      );
}

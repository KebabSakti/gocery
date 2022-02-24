class CourierRatingEntity {
  CourierRatingEntity({
    this.courierAccountUid,
    this.uid,
    this.one,
    this.two,
    this.three,
    this.four,
    this.five,
    this.ratingCount,
    this.ratingValue,
  });

  final String? courierAccountUid;
  final String? uid;
  final int? one;
  final int? two;
  final int? three;
  final int? four;
  final int? five;
  final int? ratingCount;
  final String? ratingValue;

  CourierRatingEntity copyWith({
    String? courierAccountUid,
    String? uid,
    int? one,
    int? two,
    int? three,
    int? four,
    int? five,
    int? ratingCount,
    String? ratingValue,
  }) =>
      CourierRatingEntity(
        courierAccountUid: courierAccountUid ?? this.courierAccountUid,
        uid: uid ?? this.uid,
        one: one ?? this.one,
        two: two ?? this.two,
        three: three ?? this.three,
        four: four ?? this.four,
        five: five ?? this.five,
        ratingCount: ratingCount ?? this.ratingCount,
        ratingValue: ratingValue ?? this.ratingValue,
      );
}

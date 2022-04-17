class PaymentChannelEntity {
  PaymentChannelEntity({
    this.uid,
    this.channelCode,
    this.name,
    this.currency,
    this.channelCategory,
    this.picture,
    this.fee,
    this.feeType,
    this.min,
    this.max,
    this.expire,
    this.extra,
  });

  final String? uid;
  final String? channelCode;
  final String? name;
  final String? currency;
  final String? channelCategory;
  final String? picture;
  final String? fee;
  final String? feeType;
  final int? min;
  final int? max;
  final int? expire;
  final String? extra;

  PaymentChannelEntity copyWith({
    String? uid,
    String? channelCode,
    String? name,
    String? currency,
    String? channelCategory,
    String? picture,
    String? fee,
    String? feeType,
    int? min,
    int? max,
    int? expire,
    String? extra,
  }) =>
      PaymentChannelEntity(
        uid: uid ?? this.uid,
        channelCode: channelCode ?? this.channelCode,
        name: name ?? this.name,
        currency: currency ?? this.currency,
        channelCategory: channelCategory ?? this.channelCategory,
        picture: picture ?? this.picture,
        fee: fee ?? this.fee,
        feeType: feeType ?? this.feeType,
        min: min ?? this.min,
        max: max ?? this.max,
        expire: expire ?? this.expire,
        extra: extra ?? this.extra,
      );
}

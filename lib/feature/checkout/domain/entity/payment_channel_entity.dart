class PaymentChannelEntity {
  PaymentChannelEntity({
    this.uid,
    this.channelCode,
    this.name,
    this.channelCategory,
    this.picture,
    this.fee,
    this.feeType,
  });

  final String? uid;
  final String? channelCode;
  final String? name;
  final String? channelCategory;
  final String? picture;
  final String? fee;
  final String? feeType;

  PaymentChannelEntity copyWith({
    String? uid,
    String? channelCode,
    String? name,
    String? channelCategory,
    String? picture,
    String? fee,
    String? feeType,
  }) =>
      PaymentChannelEntity(
        uid: uid ?? this.uid,
        channelCode: channelCode ?? this.channelCode,
        name: name ?? this.name,
        channelCategory: channelCategory ?? this.channelCategory,
        picture: picture ?? this.picture,
        fee: fee ?? this.fee,
        feeType: feeType ?? this.feeType,
      );
}

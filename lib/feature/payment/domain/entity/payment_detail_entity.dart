class PaymentDetailEntity {
  PaymentDetailEntity({
    this.orderUid,
    this.channelCode,
    this.referenceId,
    this.externalId,
    this.extra,
    this.status,
    this.note,
  });

  String? orderUid;
  String? channelCode;
  String? referenceId;
  String? externalId;
  String? extra;
  String? status;
  String? note;

  PaymentDetailEntity copyWith({
    String? orderUid,
    String? channelCode,
    String? referenceId,
    String? externalId,
    String? extra,
    String? status,
    String? note,
  }) =>
      PaymentDetailEntity(
        orderUid: orderUid ?? this.orderUid,
        channelCode: channelCode ?? this.channelCode,
        referenceId: referenceId ?? this.referenceId,
        externalId: externalId ?? this.externalId,
        extra: extra ?? this.extra,
        status: status ?? this.status,
        note: note ?? this.note,
      );
}

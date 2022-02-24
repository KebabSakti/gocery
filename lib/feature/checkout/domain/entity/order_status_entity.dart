class OrderStatusEntity {
  OrderStatusEntity({
    this.orderUid,
    this.uid,
    this.status,
    this.description,
    this.note,
  });

  final String? orderUid;
  final String? uid;
  final String? status;
  final String? description;
  final String? note;

  OrderStatusEntity copyWith({
    String? orderUid,
    String? uid,
    String? status,
    String? description,
    String? note,
  }) =>
      OrderStatusEntity(
        orderUid: orderUid ?? this.orderUid,
        uid: uid ?? this.uid,
        status: status ?? this.status,
        description: description ?? this.description,
        note: note ?? this.note,
      );
}

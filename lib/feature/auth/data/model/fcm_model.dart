import 'package:gocery/feature/auth/domain/entity/fcm_entity.dart';

class FcmModel extends FcmEntity {
  FcmModel({
    int? customerId,
    int? id,
    String? token,
  }) : super(
          customerId: customerId,
          id: id,
          token: token,
        );

  FcmModel copyWith({
    int? customerId,
    int? id,
    String? token,
  }) =>
      FcmModel(
        customerId: customerId ?? this.customerId,
        id: id ?? this.id,
        token: token ?? this.token,
      );

  factory FcmModel.fromJson(Map<String, dynamic> json) => FcmModel(
        customerId: json["customer_id"],
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "id": id,
        "token": token,
      };
}

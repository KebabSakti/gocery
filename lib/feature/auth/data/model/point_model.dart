import 'package:gocery/feature/auth/domain/entity/point_entity.dart';

class PointModel extends PointEntity {
  PointModel({
    int? customerId,
    int? id,
    int? point,
  }) : super(
          customerId: customerId,
          id: id,
          point: point,
        );

  PointModel copyWith({
    int? customerId,
    int? id,
    int? point,
  }) =>
      PointModel(
        customerId: customerId ?? this.customerId,
        id: id ?? this.id,
        point: point ?? this.point,
      );

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
        customerId: json["customer_id"],
        id: json["id"],
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "id": id,
        "point": point,
      };
}

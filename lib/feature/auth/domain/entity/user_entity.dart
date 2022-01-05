import 'package:gocery/feature/auth/data/model/fcm_model.dart';
import 'package:gocery/feature/auth/data/model/point_model.dart';

abstract class UserEntity {
  UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.fcm,
    this.point,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final FcmModel? fcm;
  final PointModel? point;
}

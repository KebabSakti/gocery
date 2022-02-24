import 'package:gocery/feature/partner/domain/entity/courier_fcm_entity.dart';
import 'package:gocery/feature/partner/domain/entity/courier_profile_entity.dart';
import 'package:gocery/feature/partner/domain/entity/courier_rating_entity.dart';

class CourierAccountEntity {
  CourierAccountEntity({
    this.partnerUid,
    this.uid,
    this.username,
    this.owner,
    this.courierProfileEntity,
    this.courierFcmEntity,
    this.courierRatingEntity,
  });

  final String? partnerUid;
  final String? uid;
  final String? username;
  final String? owner;
  final CourierProfileEntity? courierProfileEntity;
  final CourierFcmEntity? courierFcmEntity;
  final CourierRatingEntity? courierRatingEntity;

  CourierAccountEntity copyWith({
    String? partnerUid,
    String? uid,
    String? username,
    String? owner,
    CourierProfileEntity? courierProfileEntity,
    CourierFcmEntity? courierFcmEntity,
    CourierRatingEntity? courierRatingEntity,
  }) =>
      CourierAccountEntity(
        partnerUid: partnerUid ?? this.partnerUid,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        owner: owner ?? this.owner,
        courierProfileEntity: courierProfileEntity,
        courierFcmEntity: courierFcmEntity ?? this.courierFcmEntity,
        courierRatingEntity: courierRatingEntity,
      );
}

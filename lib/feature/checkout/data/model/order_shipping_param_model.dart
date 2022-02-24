import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';

class OrderShippingParamModel extends OrderShippingEntity {
  OrderShippingParamModel({
    String? latitude,
    String? longitude,
    String? type,
  }) : super(
          latitude: latitude,
          longitude: longitude,
          type: type,
        );

  static OrderShippingParamModel toEntity(
          {required OrderShippingParamEntity param}) =>
      OrderShippingParamModel(
        latitude: param.latitude,
        longitude: param.longitude,
        type: param.type,
      );
}

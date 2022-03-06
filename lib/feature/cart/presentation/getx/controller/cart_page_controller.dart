import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/map_exception_message.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';

class CartPageController extends GetxController {
  final appPageController = Get.find<AppPageController>();
  final cartController = Get.find<CartController>();

  void incrementItem({required CartItemEntity param}) {
    try {
      cartController.incrementCartItem(param: param);
    } on MaxOrderLimit catch (_) {
      EasyDebounce.debounce(
          'order_limit', const Duration(milliseconds: 500), _orderLimit);
    }
  }

  void decrementItem({required CartItemEntity param}) {
    cartController.decrementCartItem(param: param);
  }

  void removeItem({required CartItemEntity param}) {
    cartController.removeCartItem(param: param);
  }

  void toCheckoutPage({required List<CartItemEntity> param}) {
    Get.toNamed(kCheckoutPage, arguments: param);
  }

  _orderLimit() {
    MToast.show(MapExceptionMessage.exception(MaxOrderLimit()));
  }
}

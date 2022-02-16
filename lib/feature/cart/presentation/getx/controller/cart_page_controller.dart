import 'package:get/get.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';

class CartPageController extends GetxController {
  final cartController = Get.find<CartController>();

  void incrementItem({required CartItemEntity param}) {
    cartController.setItemQty(param: param, value: param.itemQtyTotal! + 1);
  }

  void decrementItem() {}
}

import 'package:get/get.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';

class CartPageController extends GetxController {
  final appPageController = Get.find<AppPageController>();
  final cartController = Get.find<CartController>();

  void incrementItem({required CartItemEntity param}) {
    cartController.incrementCartItem(param: param);
  }

  void decrementItem({required CartItemEntity param}) {
    cartController.decrementCartItem(param: param);
  }
}

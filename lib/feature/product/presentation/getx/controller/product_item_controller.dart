import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';

class ProductItemController extends GetxController {
  final cartController = Get.find<CartController>();

  void addToCart({required ProductEntity param}) async {
    int index = cartController.getIndex(param: param);

    if (index < 0) {
      cartController.incrementCartItem(
          param: CartItemEntity(
        productUid: param.uid,
        itemQtyTotal: 0,
        itemPriceTotal: param.finalPrice,
        productModel: param,
      ));
    }
  }

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

  _orderLimit() {
    MToast.show('Produk melebihi limit order');
  }
}

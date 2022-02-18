import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddToCartPanelController extends GetxController {
  final cartController = Get.find<CartController>();

  final panelController = PanelController();

  final cartItem = CartItemEntity().obs;

  void showPanel({required ProductEntity param}) async {
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

    cartItem(_getCartItem(param: param));

    panelController.open();
  }

  void incrementItem({required CartItemEntity param}) {
    try {
      cartController.incrementCartItem(param: param);

      cartItem(_getCartItem(param: param.productModel!));
    } on MaxOrderLimit catch (_) {
      EasyDebounce.debounce(
          'order_limit', const Duration(milliseconds: 500), _orderLimit);
    }
  }

  void decrementItem({required CartItemEntity param}) {
    cartController.decrementCartItem(param: param);

    int index = cartController.getIndex(param: param.productModel!);

    if (index >= 0) {
      cartItem(_getCartItem(param: param.productModel!));
    } else {
      panelController.close();
    }
  }

  CartItemEntity _getCartItem({required ProductEntity param}) {
    List<CartItemEntity> models = cartController.cartItemState().data!;
    int index = cartController.getIndex(param: param);

    return models[index];
  }

  _orderLimit() {
    MToast.show('Produk melebihi limit order');
  }
}

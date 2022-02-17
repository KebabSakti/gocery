import 'package:get/get.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddToCartPanelController extends GetxController {
  final cartController = Get.find<CartController>();

  final panelController = PanelController();

  final cartItem = CartItemEntity().obs;

  void showPanel({required ProductEntity param}) {
    List<CartItemEntity> models = cartController.cartItemState().data!;
    int index = models.indexWhere((element) => element.productUid == param.uid);

    if (index >= 0) {
      cartItem(models[index]);
    } else {
      cartItem(CartItemEntity(
        productUid: param.uid,
        itemQtyTotal: 1,
        itemPriceTotal: param.finalPrice,
        productModel: param,
      ));
    }

    panelController.open();
  }
}

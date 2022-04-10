import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/map_exception_message.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/getx/controller/app_page_controller.dart';
import 'package:gocery/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/usecase/cart_stock.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:gocery/feature/home/presentation/getx/controller/home_page_controller.dart';

class CartPageController extends GetxController {
  final appPageController = Get.find<AppPageController>();
  final cartController = Get.find<CartController>();
  final homePageController = Get.find<HomePageController>();

  final _cartStock = CartStock(repository: Get.find<CartRepositoryImpl>());

  final outOfStock = false.obs;

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

  void toCheckoutPage({required List<CartItemEntity> param}) async {
    try {
      MDialog.loading();

      await _cartStock(param: param.map((e) => e.productModel!.uid!).toList());

      outOfStock(false);

      MDialog.close();

      Get.toNamed(kCheckoutPage, arguments: param);
    } on OutOfStock catch (_) {
      homePageController.init();

      await cartController.getCartItems();

      MDialog.close();

      outOfStock(true);

      MToast.show(
          'Beberapa produk dalam keranjang anda kehabisan stok, update keranjang belanjaan untuk melanjutkan');
    } on Exception catch (e) {
      MDialog.close();

      MToast.show(MapExceptionMessage.exception(e));
    }
  }

  _orderLimit() {
    MToast.show(MapExceptionMessage.exception(MaxOrderLimit()));
  }
}

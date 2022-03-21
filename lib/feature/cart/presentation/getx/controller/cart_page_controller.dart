import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/map_exception_message.dart';
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

  final RxInt outOfStock = 0.obs;

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
    bool inStock = await _cartStock(
        param: param.map((e) => e.productModel!.uid!).toList());

    if (inStock) {
      Get.toNamed(kCheckoutPage, arguments: param);
    } else {
      MToast.show('Beberapa item pada keranjang kehabisan stok');

      homePageController.init();

      cartController.getCartItems();
    }
  }

  _orderLimit() {
    MToast.show(MapExceptionMessage.exception(MaxOrderLimit()));
  }

  @override
  void onInit() {
    ever(cartController.cartItemState,
        (ResponseModel<List<CartItemEntity>> response) {
      if (response.status == Status.success) {
        if (response.data!.isNotEmpty) {
          outOfStock.value = response.data!
              .where((element) => element.productModel!.stok == 0)
              .toList()
              .length;
        }
      }
    });

    super.onInit();
  }
}

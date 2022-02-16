import 'package:get/get.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/usecase/get_cart_items.dart';
import 'package:gocery/feature/cart/domain/usecase/update_cart.dart';

class CartController extends GetxController {
  final _getCartItems = GetCartItem(repository: Get.find<CartRepositoryImpl>());
  final _updateCart = UpdateCart(repository: Get.find<CartRepositoryImpl>());

  final cartItemState =
      ResponseModel<List<CartItemEntity>>(status: Status.loading, data: []).obs;

  final qtyTotal = 0.obs;
  final priceTotal = 0.00.obs;

  Future<void> getCartItems() async {
    try {
      cartItemState(cartItemState().copyWith(responseStatus: Status.loading));

      await _getCartItems().then((model) {
        cartItemState(cartItemState().copyWith(
          responseStatus: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat item keranjang');

      cartItemState(cartItemState().copyWith(responseStatus: Status.error));
    }
  }

  Future<void> updateCart({required List<CartItemEntity> param}) async {
    try {
      await _updateCart(param: param);
    } catch (e) {
      MToast.show('Gagal update keranjang');
    }
  }

  void setItemQty({required CartItemEntity param, required int value}) {
    List<CartItemEntity> models = cartItemState().data!;

    if (value > 0) {
      if (models.isNotEmpty) {
        int index = models.indexWhere((element) => element.uid == param.uid);
        double itemPriceTotal =
            value * double.parse(param.productModel!.finalPrice!);

        models[index] = models[index].copyWith(
          itemQtyTotal: value,
          itemPriceTotal: itemPriceTotal.toString(),
        );
      } else {
        models.add(param);
      }
    } else {
      models.removeWhere((element) => element.uid == param.uid);
    }

    cartItemState(cartItemState().copyWith(data: models));
  }

  void clearCart() {
    cartItemState(
        ResponseModel<List<CartItemEntity>>(status: Status.empty, data: []));
  }

  int _calculateTotalQty({required List<CartItemEntity> param}) {
    int total = param.fold(0, (sum, item) => sum + item.itemQtyTotal!);

    return total;
  }

  double _calculateTotalPrice({required List<CartItemEntity> param}) {
    double total =
        param.fold(0, (sum, item) => sum + double.parse(item.itemPriceTotal!));

    return total;
  }

  void initListener() {
    ever(cartItemState, (ResponseModel<List<CartItemEntity>> state) {
      if (state.status == Status.success) {
        qtyTotal(_calculateTotalQty(param: state.data!));

        priceTotal(_calculateTotalPrice(param: state.data!));
      }
    });

    debounce(cartItemState, (ResponseModel<List<CartItemEntity>> state) {
      if (state.status == Status.success) {
        updateCart(param: state.data!);
      }
    }, time: const Duration(milliseconds: 200));
  }

  void init() {
    getCartItems();
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}

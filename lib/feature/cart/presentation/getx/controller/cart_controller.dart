import 'package:get/get.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/usecase/get_cart_items.dart';
import 'package:gocery/feature/cart/domain/usecase/update_cart.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';

class CartController extends GetxController {
  final _getCartItems = GetCartItem(repository: Get.find<CartRepositoryImpl>());
  final _updateCart = UpdateCart(repository: Get.find<CartRepositoryImpl>());

  final cartItemState =
      ResponseModel<List<CartItemEntity>>(status: Status.loading, data: []).obs;

  final qtyTotal = 0.obs;
  final priceTotal = 0.00.obs;

  Future<void> getCartItems() async {
    try {
      cartItemState(cartItemState().copyWith(status: Status.loading));

      await _getCartItems().then((model) {
        cartItemState(cartItemState().copyWith(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat item keranjang');

      cartItemState(cartItemState().copyWith(status: Status.error));
    }
  }

  Future<void> updateCart({required List<CartItemEntity> param}) async {
    try {
      await _updateCart(param: param);
    } catch (e) {
      MToast.show('Gagal update keranjang');
    }
  }

  void setItemQty({required CartItemEntity param, required int qty}) {
    List<CartItemEntity> models = cartItemState().data!;

    if (qty > 0) {
      int index = models
          .indexWhere((element) => element.productUid == param.productUid);

      if (index >= 0) {
        double itemPriceTotal =
            qty * double.parse(param.productModel!.finalPrice!);

        models[index] = CartItemModel(
          customerAccountUid: param.customerAccountUid,
          productUid: param.productUid,
          uid: param.uid,
          note: param.note,
          productModel: param.productModel as ProductModel,
          itemQtyTotal: qty,
          itemPriceTotal: itemPriceTotal.toString(),
        );
      } else {
        models.add(CartItemModel(
          customerAccountUid: param.customerAccountUid,
          productUid: param.productUid,
          uid: param.uid,
          note: param.note,
          productModel: param.productModel as ProductModel,
          itemQtyTotal: qty,
          itemPriceTotal: param.itemPriceTotal,
        ));
      }
    } else {
      models.removeWhere((element) => element.productUid == param.productUid);
    }

    cartItemState(cartItemState().copyWith(data: models));
  }

  void incrementCartItem({required CartItemEntity param}) {
    int qtyTotal = param.itemQtyTotal! + 1;

    if (qtyTotal > param.productModel!.maxOrder! ||
        qtyTotal > param.productModel!.stok!) {
      throw MaxOrderLimit();
    }

    setItemQty(param: param, qty: qtyTotal);
  }

  void decrementCartItem({required CartItemEntity param}) {
    if (param.itemQtyTotal! > 0) {
      setItemQty(param: param, qty: param.itemQtyTotal! - 1);
    } else {
      setItemQty(param: param, qty: 0);
    }
  }

  void removeCartItem({required CartItemEntity param}) {
    setItemQty(param: param, qty: 0);
  }

  void clearCart() {
    cartItemState(
        ResponseModel<List<CartItemEntity>>(status: Status.empty, data: []));
  }

  int getIndex({required ProductEntity param}) {
    List<CartItemEntity> models = cartItemState().data!;
    int index = models.indexWhere((element) => element.productUid == param.uid);

    return index;
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

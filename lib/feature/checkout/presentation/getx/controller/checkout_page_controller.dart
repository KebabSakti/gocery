import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/checkout/data/repository/order_repository_impl.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_last_address.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_order_shipping.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutPageController extends GetxController {
  final List<CartItemEntity> cartItems = Get.arguments;

  final PanelController deliveryTimePanel = PanelController();
  final PanelController paymentChannelPanel = PanelController();

  final _getLastAddress =
      GetLastAddress(repository: Get.find<OrderRepositoryImpl>());
  final _getOrderShipping =
      GetOrderShipping(repository: Get.find<OrderRepositoryImpl>());

  final addressState =
      ResponseModel<ShippingAddressEntity>(status: Status.loading).obs;
  final orderShippingState =
      ResponseModel<List<OrderShippingEntity>>(status: Status.loading).obs;

  final orderSummaryState = OrderEntity().obs;

  Future<void> getLastAddress() async {
    try {
      addressState(
          ResponseModel<ShippingAddressEntity>(status: Status.loading));

      ShippingAddressEntity addressEntity = await _getLastAddress();

      addressState(ResponseModel<ShippingAddressEntity>(
          status: Status.success, data: addressEntity));

      orderSummaryState(
          orderSummaryState().copyWith(shippingAddressEntity: addressEntity));
    } catch (e) {
      MToast.show('Gagal memuat riwayat alamat');

      addressState(ResponseModel<ShippingAddressEntity>(status: Status.error));
    }
  }

  Future<void> getOrderShipping(
      {required OrderShippingParamEntity param}) async {
    try {
      orderShippingState(
          ResponseModel<List<OrderShippingEntity>>(status: Status.loading));

      List<OrderShippingEntity> shippings =
          await _getOrderShipping(param: param);

      orderShippingState(ResponseModel<List<OrderShippingEntity>>(
          status: Status.success, data: shippings));

      orderSummaryState(orderSummaryState().copyWith(
          orderShippingEntity: shippings,
          shippingFee: _totalShipping(param: shippings).toString()));
    } catch (e) {
      MToast.show('Gagal memuat detail pengiriman');

      orderShippingState(
          ResponseModel<List<OrderShippingEntity>>(status: Status.error));
    }
  }

  void getCartItems({required List<CartItemEntity> param}) {
    orderSummaryState(orderSummaryState().copyWith(
        cartItemEntity: param,
        priceTotal: _totalCartItem(param: param).toString()));
  }

  void setPaymentChannel({required PaymentChannelEntity param}) {
    orderSummaryState(orderSummaryState()
        .copyWith(paymentChannelEntity: param, appFee: param.fee));
  }

  void setOrderSummary() {
    orderSummaryState(orderSummaryState().copyWith(
      shippingAddressEntity: addressState().data,
      orderShippingEntity: orderShippingState().data,
    ));
  }

  double _totalShipping({required List<OrderShippingEntity> param}) {
    double total =
        param.fold(0, (sum, item) => sum + double.parse(item.price!));

    return total;
  }

  double _totalCartItem({required List<CartItemEntity> param}) {
    double total =
        param.fold(0, (sum, item) => sum + double.parse(item.itemPriceTotal!));

    return total;
  }

  double _appFee({required OrderEntity param}) {
    if (param.paymentChannelEntity == null) {
      return 0;
    }

    if (param.paymentChannelEntity!.feeType == 'percentage') {}

    return 0;
  }

  double _totalVoucher() {
    return 0;
  }

  double _totalPoint() {
    return 0;
  }

  double _totalPay({required OrderEntity param}) {
    double carts = _totalCartItem(param: param.cartItemEntity!);
    double shipping = _totalShipping(param: param.orderShippingEntity!);
    double voucher = _totalVoucher();
    double point = _totalPoint();
    // double appFee =

    double total = (carts + shipping) - (voucher + point);

    return total;
  }

  void toDeliveryAddressPage() async {
    await Permission.location.request();

    if (await Permission.location.request().isGranted) {
      await Get.toNamed(kDeliveryAddressPage);
    }
  }

  Future<bool> onBackButtonPressed() async {
    if (deliveryTimePanel.isPanelOpen) {
      deliveryTimePanel.close();
    }

    if (paymentChannelPanel.isPanelOpen) {
      paymentChannelPanel.close();
    }

    if (paymentChannelPanel.isPanelClosed && deliveryTimePanel.isPanelClosed) {
      return true;
    }

    return false;
  }

  void initListener() {
    ever(addressState, (ResponseModel<ShippingAddressEntity> model) {
      if (model.data != null) {
        getOrderShipping(
            param: OrderShippingParamEntity(
          latitude: model.data!.latitude,
          longitude: model.data!.longitude,
          type: Utility.getCartItemTypes(param: cartItems),
        ));
      }
    });
  }

  void init() async {
    getCartItems(param: cartItems);

    getLastAddress();
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}

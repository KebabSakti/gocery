import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/checkout/data/repository/order_repository_impl.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_last_address.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_order_shipping.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_shipping_times.dart';
import 'package:gocery/feature/customer/data/repository/customer_repository_impl.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/usecase/show_customer_account.dart';
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
  final _getCustomerAccount =
      ShowCustomerAccount(repository: Get.find<CustomerRepositoryImpl>());
  final _getShippingTimes =
      GetShippingTimes(repository: Get.find<OrderRepositoryImpl>());

  final addressState =
      ResponseModel<ShippingAddressEntity>(status: Status.loading).obs;
  final orderShippingState =
      ResponseModel<List<OrderShippingEntity>>(status: Status.loading).obs;
  final customerAccount =
      ResponseModel<CustomerAccountEntity>(status: Status.loading).obs;
  final shippingTimesState =
      ResponseModel<List<ShippingTimeEntity>>(status: Status.loading).obs;
  final Rx<PaymentChannelEntity?> paymentChannelState = null.obs;
  final Rx<VoucherEntity?> voucherState = null.obs;

  final priceTotal = 0.0.obs;
  final shippingFee = 0.0.obs;
  final appFee = 0.0.obs;
  final voucher = 0.0.obs;
  final point = 0.0.obs;
  final payTotal = 0.0.obs;

  final checkbox = false.obs;

  Future<void> setAddressState() async {
    try {
      addressState(
          ResponseModel<ShippingAddressEntity>(status: Status.loading));

      ShippingAddressEntity addressEntity = await _getLastAddress();

      if (addressEntity.latitude == '' || addressEntity.longitude == '') {
        addressState(
            ResponseModel<ShippingAddressEntity>(status: Status.empty));
      } else {
        addressState(ResponseModel<ShippingAddressEntity>(
            status: Status.success, data: addressEntity));
      }
    } catch (e) {
      MToast.show('Gagal memuat riwayat alamat');

      addressState(ResponseModel<ShippingAddressEntity>(status: Status.error));
    }
  }

  Future<void> setOrderShippingState() async {
    try {
      orderShippingState(
          ResponseModel<List<OrderShippingEntity>>(status: Status.loading));

      if (addressState().data == null) {
        orderShippingState(
            ResponseModel<List<OrderShippingEntity>>(status: Status.empty));
      } else {
        List<OrderShippingEntity> shippings = await _getOrderShipping(
            param: OrderShippingParamEntity(
          latitude: addressState().data!.latitude,
          longitude: addressState().data!.longitude,
          type: Utility.getCartItemTypes(param: cartItems),
        ));

        orderShippingState(ResponseModel<List<OrderShippingEntity>>(
            status: Status.success, data: shippings));
      }
    } catch (e) {
      MToast.show('Gagal memuat detail pengiriman');

      orderShippingState(
          ResponseModel<List<OrderShippingEntity>>(status: Status.error));
    }
  }

  Future<void> setCustomerPoint() async {
    try {
      customerAccount(
          ResponseModel<CustomerAccountEntity>(status: Status.loading));

      await _getCustomerAccount().then((model) {
        customerAccount(ResponseModel<CustomerAccountEntity>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat point');

      customerAccount(
          ResponseModel<CustomerAccountEntity>(status: Status.error));
    }
  }

  Future<void> setShippingTimesState() async {
    try {
      shippingTimesState(
          ResponseModel<List<ShippingTimeEntity>>(status: Status.loading));

      List<ShippingTimeEntity> models = await _getShippingTimes();

      shippingTimesState(ResponseModel<List<ShippingTimeEntity>>(
          status: Status.success, data: models));
    } catch (e) {
      MToast.show('Gagal memuat jam pengiriman');

      shippingTimesState(
          ResponseModel<List<ShippingTimeEntity>>(status: Status.error));
    }
  }

  void setCheckbox({bool? value}) {
    if (value != null) {
      checkbox(value);
    }
  }

  void setAddressNote({required String note}) {
    addressState(
      addressState().copyWith(data: addressState().data!.copyWith(note: note)),
    );
  }

  void openDeliveryTimerPanel() async {
    setShippingTimesState();

    deliveryTimePanel.open();
  }

  double _totalShipping() {
    if (orderShippingState().data == null) {
      return 0.0;
    }

    double total = orderShippingState()
        .data!
        .fold(0, (sum, item) => sum + double.parse(item.price!));

    return total;
  }

  double _totalCartItem() {
    double total = cartItems.fold(
        0, (sum, item) => sum + double.parse(item.itemPriceTotal!));

    return total;
  }

  double _totalAppFee() {
    if (paymentChannelState() == null) {
      return 0.0;
    }

    if (paymentChannelState()!.feeType == 'fix') {
      return double.parse(paymentChannelState()!.fee!);
    }

    double total = (double.parse(paymentChannelState()!.fee!) / 100) *
        (_totalCartItem() + _totalShipping());

    return total;
  }

  double _totalVoucher() {
    if (voucherState() == null) {
      return 0.0;
    }

    return double.parse(voucherState()!.amount!);
  }

  double _totalPoint() {
    if (customerAccount().data == null) {
      return 0.0;
    }

    return double.parse(
        customerAccount().data!.customerPointEntity!.point!.toString());
  }

  void _calculateTotal() {
    double pt = !checkbox() ? 0.0 : _totalPoint();
    double pay = (_totalCartItem() + _totalShipping() + _totalAppFee()) -
        (_totalVoucher() + pt);

    priceTotal(_totalCartItem());
    shippingFee(_totalShipping());
    appFee(_totalAppFee());
    voucher(_totalVoucher());
    point(_totalPoint());

    payTotal(pay);
  }

  void toDeliveryAddressPage() async {
    await Permission.location.request();

    if (await Permission.location.request().isGranted) {
      var result = await Get.toNamed(kDeliveryAddressPage,
          arguments: addressState().data);

      if (result != null) {
        addressState(addressState().copyWith(data: result));
      }
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
    ever(addressState, (_) {
      setOrderShippingState();
    });

    ever(orderShippingState, (_) {
      _calculateTotal();
    });

    ever(paymentChannelState, (_) {
      _calculateTotal();
    });

    ever(voucherState, (_) {
      _calculateTotal();
    });

    ever(customerAccount, (_) {
      _calculateTotal();
    });

    ever(checkbox, (_) {
      _calculateTotal();
    });
  }

  void init() {
    setAddressState();

    setCustomerPoint();
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}

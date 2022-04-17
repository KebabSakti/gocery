import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/service/error/base_exception.dart';
import 'package:gocery/core/service/error/business_exception.dart';
import 'package:gocery/core/service/error/map_exception_message.dart';
import 'package:gocery/core/service/websocket/websocket.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/cart/data/model/cart_item_model.dart';
import 'package:gocery/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:gocery/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:gocery/feature/cart/domain/usecase/cart_stock.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/voucher_model.dart';
import 'package:gocery/feature/checkout/data/repository/order_repository_impl.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_default_payment_channel.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_last_address.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_order_shipping.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_payment_channel.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_shipping_times.dart';
import 'package:gocery/feature/checkout/domain/usecase/get_vouchers.dart';
import 'package:gocery/feature/checkout/domain/usecase/submit_order.dart';
import 'package:gocery/feature/customer/data/repository/customer_repository_impl.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/usecase/show_customer_account.dart';
import 'package:gocery/feature/home/presentation/getx/controller/home_page_controller.dart';
import 'package:gocery/feature/product/data/model/product_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutPageController extends GetxController {
  final websocket = Get.find<WebsocketImpl>();

  final OrderParamEntity orderParamEntity = Get.arguments;

  final PanelController deliveryTimePanel = PanelController();
  final PanelController paymentChannelPanel = PanelController();
  final PanelController voucherPanel = PanelController();

  final cartController = Get.find<CartController>();
  final homePageController = Get.find<HomePageController>();

  final _getLastAddress =
      GetLastAddress(repository: Get.find<OrderRepositoryImpl>());
  final _getOrderShipping =
      GetOrderShipping(repository: Get.find<OrderRepositoryImpl>());
  final _getCustomerAccount =
      ShowCustomerAccount(repository: Get.find<CustomerRepositoryImpl>());
  final _getShippingTimes =
      GetShippingTimes(repository: Get.find<OrderRepositoryImpl>());
  final _getChannelState =
      GetPaymentChannel(repository: Get.find<OrderRepositoryImpl>());
  final _getDefaultPayment =
      GetDefaultPaymentChannel(repository: Get.find<OrderRepositoryImpl>());
  final _getVouchers = GetVouchers(repository: Get.find<OrderRepositoryImpl>());
  final _cartStock = CartStock(repository: Get.find<CartRepositoryImpl>());

  final _submitOrder = SubmitOrder(repository: Get.find<OrderRepositoryImpl>());

  final addressState =
      ResponseModel<ShippingAddressEntity>(status: Status.loading).obs;
  final orderShippingState =
      ResponseModel<List<OrderShippingEntity>>(status: Status.loading).obs;
  final customerAccount =
      ResponseModel<CustomerAccountEntity>(status: Status.loading).obs;
  final shippingTimesState =
      ResponseModel<List<ShippingTimeEntity>>(status: Status.loading).obs;
  final channelState =
      ResponseModel<List<PaymentChannelEntity>>(status: Status.loading).obs;
  final defaultChannelState =
      ResponseModel<PaymentChannelEntity>(status: Status.loading).obs;
  final voucherState =
      ResponseModel<List<VoucherEntity>>(status: Status.loading).obs;

  final priceTotal = 0.0.obs;
  final shippingFee = 0.0.obs;
  final appFee = 0.0.obs;
  final voucher = 0.0.obs;
  final point = 0.0.obs;
  final payTotal = 0.0.obs;
  final checkbox = false.obs;
  final itemsOutOfStock = false.obs;
  final payment = true.obs;
  // final closed = false.obs;

  String uid = Utility.randomUid();

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
    double total = orderParamEntity.cartItems!
        .fold(0, (sum, item) => sum + double.parse(item.itemPriceTotal!));

    return total;
  }

  int _totalCartItemQty() {
    int total = orderParamEntity.cartItems!
        .fold(0, (sum, item) => sum + item.itemQtyTotal!);

    return total;
  }

  double _totalAppFee() {
    if (defaultChannelState().data == null) {
      return 0.0;
    }

    if (defaultChannelState().data!.feeType == 'fix') {
      return double.parse(defaultChannelState().data!.fee!);
    }

    double total = (double.parse(defaultChannelState().data!.fee!) / 100) *
        (_totalCartItem() + _totalShipping());

    return total;
  }

  double _totalVoucher() {
    if (voucherState().data == null) {
      return 0.0;
    }

    List<VoucherEntity> selectedVouchers = voucherState()
        .data!
        .where((element) => element.selected == true)
        .toList();

    double total = selectedVouchers.fold(
        0, (sum, item) => sum + double.parse(item.amount!));

    return total;
  }

  double _totalPoint() {
    if (customerAccount().data == null) {
      return 0.0;
    }

    if (!checkbox()) {
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

    double total = pay.isNegative ? 0.0 : pay;

    payTotal(total);
  }

  void _validatePaymentRule({required PaymentChannelEntity paymentChannel}) {
    if (paymentChannel.channelCode != 'COD') {
      if (payTotal() > paymentChannel.max! ||
          payTotal() < paymentChannel.min!) {
        payment(false);
      } else {
        payment(true);
      }
    } else {
      payment(true);
    }
  }

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
          type: Utility.getCartItemTypes(param: orderParamEntity.cartItems!),
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

  Future<void> setChannelState() async {
    try {
      channelState(
          ResponseModel<List<PaymentChannelEntity>>(status: Status.loading));

      List<PaymentChannelEntity> models = await _getChannelState();

      channelState(ResponseModel<List<PaymentChannelEntity>>(
          status: Status.success, data: models));
    } catch (e) {
      MToast.show('Gagal memuat metode pembayaran');

      channelState(
          ResponseModel<List<PaymentChannelEntity>>(status: Status.error));
    }
  }

  Future<void> setDefaultChannelState() async {
    try {
      defaultChannelState(
          ResponseModel<PaymentChannelEntity>(status: Status.loading));

      PaymentChannelEntity model = await _getDefaultPayment();

      defaultChannelState(ResponseModel<PaymentChannelEntity>(
          status: Status.success, data: model));
    } catch (e) {
      MToast.show('Gagal memuat metode pembayaran');

      defaultChannelState(
          ResponseModel<PaymentChannelEntity>(status: Status.error));
    }
  }

  Future<void> setVoucherState() async {
    try {
      voucherState(ResponseModel<List<VoucherEntity>>(status: Status.loading));

      List<VoucherEntity> models = await _getVouchers();

      voucherState(ResponseModel<List<VoucherEntity>>(
          status: Status.success, data: models));
    } catch (e) {
      MToast.show('Gagal memuat voucher');

      voucherState(ResponseModel<List<VoucherEntity>>(status: Status.error));
    }
  }

  void setCheckbox({bool? value}) {
    if (value != null) {
      checkbox(value);
    }
  }

  void setAddressNote({required String note}) {
    if (note.isNotEmpty) {
      addressState(
        addressState()
            .copyWith(data: addressState().data!.copyWith(note: note)),
      );
    }
  }

  void setShippingTime({required String time}) {
    List<OrderShippingEntity> models = orderShippingState().data!;

    int index = models.indexWhere((element) => element.shipping == 'TERJADWAL');

    if (index >= 0) {
      models[index] = OrderShippingModel(
        address: models[index].address,
        distance: models[index].distance,
        distanceUnit: models[index].distanceUnit,
        latitude: models[index].latitude,
        longitude: models[index].longitude,
        name: models[index].name,
        online: models[index].online,
        phone: models[index].phone,
        price: models[index].price,
        shipping: models[index].shipping,
        type: models[index].type,
        uid: models[index].uid,
        time: time,
      );

      orderShippingState(orderShippingState().copyWith(data: models));

      deliveryTimePanel.close();
    }
  }

  void setCartItemNote({required CartItemEntity param}) {
    int index = orderParamEntity.cartItems!
        .indexWhere((element) => element.productUid == param.productUid);

    if (index >= 0) {
      orderParamEntity.cartItems![index] = CartItemModel(
        customerAccountUid:
            orderParamEntity.cartItems![index].customerAccountUid,
        itemPriceTotal: orderParamEntity.cartItems![index].itemPriceTotal,
        itemQtyTotal: orderParamEntity.cartItems![index].itemQtyTotal,
        productModel:
            orderParamEntity.cartItems![index].productModel as ProductModel,
        productUid: orderParamEntity.cartItems![index].productUid,
        uid: orderParamEntity.cartItems![index].uid,
        note: param.note,
      );
    }
  }

  void setPayment({required PaymentChannelEntity param}) {
    if (param.channelCode == 'ID_OVO' && param.extra == null) {
      setOvoNumber(param: param);
    } else {
      defaultChannelState(defaultChannelState().copyWith(data: param));

      paymentChannelPanel.close();

      _validatePaymentRule(paymentChannel: param);
    }
  }

  void setVoucher({required VoucherEntity param}) {
    List<VoucherEntity> models = voucherState().data!;

    int index = models.indexWhere((element) => element.uid == param.uid);

    if (index >= 0) {
      models[index] = VoucherModel(
        amount: param.amount,
        code: param.code,
        description: param.description,
        expiredAt: param.expiredAt,
        image: param.image,
        max: param.max,
        minOrder: param.minOrder,
        startAt: param.startAt,
        title: param.title,
        uid: param.uid,
        selected: param.selected,
      );

      voucherState(voucherState().copyWith(data: models));
    }
  }

  void setOvoNumber({required PaymentChannelEntity param}) {
    Get.dialog(
      AlertDialog(
        title: const Text('Nomor OVO anda'),
        content: TextField(
          controller: TextEditingController()..text = param.extra ?? '',
          keyboardType: TextInputType.phone,
          autofocus: true,
          style: Get.textTheme.headline3,
          decoration: const InputDecoration(
            suffixIconConstraints: BoxConstraints(),
            suffixIcon: Icon(AppIcon.phoneandorid),
          ),
          onSubmitted: (value) {
            try {
              if (!Utility.validatePhone(phone: value)) {
                throw InvalidPhoneNumber();
              }

              defaultChannelState(defaultChannelState()
                  .copyWith(data: param.copyWith(extra: value)));

              Get.back();

              paymentChannelPanel.close();

              _validatePaymentRule(paymentChannel: param);
            } on Exception catch (e) {
              MToast.show(MapExceptionMessage.exception(e));
            }
          },
        ),
      ),
    );
  }

  void openDeliveryTimePanel() {
    setShippingTimesState();

    deliveryTimePanel.open();
  }

  void openPaymentChannelPanel() {
    setChannelState();

    paymentChannelPanel.open();
  }

  void openVoucherPanel() {
    voucherPanel.open();
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

  Future<void> toFindCourierPage() async {
    try {
      MDialog.loading();

      await _cartStock(
          param: orderParamEntity.cartItems!
              .map((e) => e.productModel!.uid!)
              .toList());

      itemsOutOfStock(false);

      OrderEntity param = OrderEntity(
        uid: Utility.randomUid(),
        cartItemEntity: orderParamEntity.cartItems!,
        shippingAddressEntity: addressState().data,
        orderShippingEntity: orderShippingState().data,
        paymentChannelEntity: defaultChannelState().data,
        voucherEntity: voucherState().data,
        qtyTotal: _totalCartItemQty(),
        priceTotal: priceTotal().toString(),
        shippingFee: shippingFee().toString(),
        appFee: appFee().toString(),
        voucherDeduction: voucher().toString(),
        pointDeduction: point().toString(),
        payTotal: payTotal().toString(),
      );

      await _submitOrder(param: param);

      if (orderParamEntity.clearCart!) {
        await cartController.clearCart();
      }

      MDialog.close();

      Get.toNamed(kFindCourierPage, arguments: param);
    } on OutOfStock catch (_) {
      homePageController.init();

      await cartController.getCartItems();

      MDialog.close();

      itemsOutOfStock(true);

      MToast.show(
          'Beberapa produk dalam keranjang anda kehabisan stok, update keranjang belanjaan untuk melanjutkan');
    } on Exception catch (e, t) {
      throw BaseException(e, t);
    }
  }

  Future<bool> onBackButtonPressed() async {
    if (deliveryTimePanel.isPanelOpen) {
      deliveryTimePanel.close();
    }

    if (paymentChannelPanel.isPanelOpen) {
      paymentChannelPanel.close();
    }

    if (voucherPanel.isPanelOpen) {
      voucherPanel.close();
    }

    if (paymentChannelPanel.isPanelClosed &&
        deliveryTimePanel.isPanelClosed &&
        voucherPanel.isPanelClosed) {
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

    ever(defaultChannelState, (_) {
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

    ever(payTotal, (_) {
      if (defaultChannelState().data != null) {
        _validatePaymentRule(paymentChannel: defaultChannelState().data!);
      }
    });
  }

  void init() async {
    setAddressState();

    setDefaultChannelState();

    setCustomerPoint();

    setVoucherState();
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}

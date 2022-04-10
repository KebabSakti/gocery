import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/websocket/websocket.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/feature/checkout/data/repository/order_repository_impl.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/usecase/cancel_order.dart';

class FindCourierPageController extends GetxController {
  final OrderEntity _order = Get.arguments;

  final _websocket = Get.find<WebsocketImpl>();
  final _cancelOrder = CancelOrder(repository: Get.find<OrderRepositoryImpl>());

  int courierCount = 0;

  void cancel() async {
    MDialog.prompt(
        'Orderan akan di batalkan, proses ini tidak dapat dikembalikan, lanjutkan ?',
        onOk: () async {
      await _cancelOrder(orderUid: _order.uid!);

      await _unsubscribeChannel();

      Get.back(closeOverlays: true);
    });
  }

  void _listenToChannel() {
    _websocket.listen(
      channelName: 'private-order.${_order.uid}',
      eventName: 'OrderStatusEvent',
      onEvent: (event) {
        courierCount += 1;

        if (courierCount == _order.orderShippingEntity!.length) {
          _toOrderCompletePage();
        }
      },
    );
  }

  Future<void> _unsubscribeChannel() async {
    await _websocket.close(channelName: 'order.${_order.uid}');
  }

  void _toOrderCompletePage() {
    Get.offAllNamed(kOrderCompletePage);
  }

  void init() {
    _listenToChannel();
  }

  @override
  void onInit() {
    init();

    super.onInit();
  }
}

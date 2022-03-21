import 'package:awesome_notifications/awesome_notifications.dart';

abstract class NotificationContract {
  void init();

  Future<bool> isAllowed();

  Future<void> permission();

  void service();

  void order();

  void orderStatus({required String title, required String body});

  void chat({required String title, required String body});

  void promo({required String title, required String body});

  void listen(void Function(ReceivedNotification receivedNotification)? onData);

  void closeService();

  void cancel({required int id});

  void cancelAll();
}

class NotificationImpl implements NotificationContract {
  NotificationImpl({required this.implementation}) {
    init();
  }

  final NotificationContract implementation;

  @override
  void init() {
    implementation.init();
  }

  @override
  Future<bool> isAllowed() async {
    return await implementation.isAllowed();
  }

  @override
  Future<void> permission() async {
    return implementation.permission();
  }

  @override
  void cancel({required int id}) {
    implementation.cancel(id: id);
  }

  @override
  void cancelAll() {
    implementation.cancelAll();
  }

  @override
  void closeService() {
    implementation.closeService();
  }

  @override
  void listen(
      void Function(ReceivedNotification receivedNotification)? onData) {
    implementation.listen(onData);
  }

  @override
  void order() {
    implementation.order();
  }

  @override
  void promo({
    required String title,
    required String body,
  }) {
    implementation.promo(title: title, body: body);
  }

  @override
  void service() {
    implementation.service();
  }

  @override
  void chat({
    required String title,
    required String body,
  }) {
    implementation.chat(title: title, body: body);
  }

  @override
  void orderStatus({
    required String title,
    required String body,
  }) {
    implementation.orderStatus(title: title, body: body);
  }
}

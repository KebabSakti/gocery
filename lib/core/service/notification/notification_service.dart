import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/notification/notification.dart';

class NotificationService implements NotificationContract {
  NotificationService() {
    init();
  }

  @override
  void init() {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          defaultColor: kPrimaryColor,
          ledColor: kPrimaryColor,
          channelKey: kOrderChannelKey,
          channelName: 'Order Notification Setting',
          channelGroupKey: kOrderChannelGroupKey,
          channelDescription: 'Notification setting for new order',
          importance: NotificationImportance.Max,
          locked: true,
        ),
        NotificationChannel(
          defaultColor: kPrimaryColor,
          ledColor: kPrimaryColor,
          channelKey: kOrderStatusChannelKey,
          channelName: 'Order Status Notification Setting',
          channelGroupKey: kOrderStatusChannelGroupKey,
          channelDescription: 'Notification setting for status order',
          importance: NotificationImportance.Max,
          locked: true,
        ),
        NotificationChannel(
          defaultColor: kPrimaryColor,
          ledColor: kPrimaryColor,
          channelKey: kChatChannelKey,
          channelName: 'Chat Notification Setting',
          channelGroupKey: kChatChannelGroupKey,
          channelDescription: 'Notification setting for chatting',
          importance: NotificationImportance.Max,
          locked: true,
        ),
        NotificationChannel(
          defaultColor: kPrimaryColor,
          ledColor: kPrimaryColor,
          channelKey: kPromoChannelKey,
          channelName: 'Promo Notification Setting',
          channelGroupKey: kPromoChannelGroupKey,
          channelDescription: 'Notification setting for promotion',
          importance: NotificationImportance.Default,
        ),
        NotificationChannel(
          defaultColor: kPrimaryColor,
          ledColor: kPrimaryColor,
          channelKey: kServiceChannelKey,
          channelName: 'Service Notification Setting',
          channelGroupKey: kServiceChannelGroupKey,
          channelDescription: 'Notification setting for service',
          importance: NotificationImportance.Max,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupkey: kOrderChannelGroupKey,
          channelGroupName: 'Order',
        ),
        NotificationChannelGroup(
          channelGroupkey: kOrderStatusChannelGroupKey,
          channelGroupName: 'Order Status',
        ),
        NotificationChannelGroup(
          channelGroupkey: kChatChannelGroupKey,
          channelGroupName: 'Chat',
        ),
        NotificationChannelGroup(
          channelGroupkey: kPromoChannelGroupKey,
          channelGroupName: 'Promo',
        ),
        NotificationChannelGroup(
          channelGroupkey: kServiceChannelGroupKey,
          channelGroupName: 'Service',
        ),
      ],
      debug: true,
    );
  }

  @override
  void order() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: kOrderChannelKey,
        id: 1,
        title: 'Orderan Baru',
        body: 'Anda mendapatkan orderan masuk',
        category: NotificationCategory.Call,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'ACCEPT',
          label: 'Terima',
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'REJECT',
          label: 'Tolak',
          isDangerousOption: true,
          autoDismissible: true,
        ),
      ],
    );
  }

  @override
  void chat({
    required String title,
    required String body,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: kChatChannelKey,
        id: 2,
        title: title,
        body: body,
        category: NotificationCategory.Message,
      ),
    );
  }

  @override
  void orderStatus({
    required String title,
    required String body,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: kOrderStatusChannelKey,
        id: 3,
        title: title,
        body: body,
        category: NotificationCategory.Status,
      ),
    );
  }

  @override
  void promo({
    required String title,
    required String body,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: kPromoChannelKey,
        id: 4,
        title: title,
        body: body,
        category: NotificationCategory.Promo,
      ),
    );
  }

  @override
  void service() {
    AndroidForegroundService.startForeground(
      content: NotificationContent(
        channelKey: kServiceChannelKey,
        id: 5,
        title: 'Gocery Partner',
        body: 'Service is running',
        category: NotificationCategory.Service,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OFFLINE',
          label: 'GO OFFLINE',
          color: Colors.red,
          autoDismissible: true,
        )
      ],
    );
  }

  @override
  Future<void> permission() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @override
  void cancel({required int id}) {
    AwesomeNotifications().cancel(id);
  }

  @override
  void cancelAll() {
    AwesomeNotifications().cancelAll();
  }

  @override
  void closeService() {
    AndroidForegroundService.stopForeground();
  }

  @override
  Future<bool> isAllowed() async {
    bool allowed = await AwesomeNotifications().isNotificationAllowed();

    return allowed;
  }

  @override
  void listen(
      void Function(ReceivedNotification receivedNotification)? onData) {
    AwesomeNotifications().actionStream.listen(onData);
  }
}

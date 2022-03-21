import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';

class FindCourierPageController extends GetxController {
  int id = 0;

  void cancel() async {
    await Future.delayed(const Duration(seconds: 5));

    id += 1;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Simple Notification',
        body: 'Simple body',
        payload: {'key': 'value'},
      ),
    );
  }
}

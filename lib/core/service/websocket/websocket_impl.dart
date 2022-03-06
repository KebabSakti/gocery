import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/websocket/websocket.dart';
import 'package:pusher_client/pusher_client.dart';

class WebsocketImpl implements Websocket {
  PusherClient? _pusherClient;

  PusherClient? _instance() {
    PusherOptions options = PusherOptions(
      host: kWebsocketHost,
      wsPort: kWebsocketWsPort,
      wssPort: kWebsocketWssPort,
      encrypted: kWebsocketEncrypt,
    );

    _pusherClient ??= PusherClient(
      kWebsocketKey,
      options,
      enableLogging: true,
      autoConnect: true,
    );

    return _pusherClient;
  }

  @override
  void unSubscribeToChannel({required String channelName}) {
    _instance()?.unsubscribe(channelName);
  }

  @override
  void bindChannel({
    required String channelName,
    required String eventName,
    required void Function(PusherEvent? event) onEvent,
  }) {
    Channel? channel = _instance()?.subscribe(channelName);

    if (channel != null) {
      channel.bind(eventName, onEvent);
    }
  }
}

import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/core/service/websocket/websocket.dart';
import 'package:pusher_client/pusher_client.dart';

class WebsocketService implements Websocket {
  static const String url = kBaseUrl + kBroadcastAuth;

  Future<String> _token() async {
    //access secure local storage for authorization token
    final SecureStorageImpl _sBox = Get.find();

    //authorization token
    final String token = await _sBox.read(key: 'token') ?? '';

    return token;
  }

  Future<PusherClient> _instance() async {
    String token = await _token();

    PusherOptions options = PusherOptions(
      host: kHost,
      wsPort: kWebsocketWsPort,
      wssPort: kWebsocketWssPort,
      encrypted: kWebsocketEncrypt,
      auth: PusherAuth(
        url,
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    var _pusherClient = PusherClient(
      kWebsocketKey,
      options,
      enableLogging: true,
      autoConnect: true,
    );

    return _pusherClient;
  }

  @override
  Future<void> listen({
    required String channelName,
    required String eventName,
    required void Function(PusherEvent? event) onEvent,
  }) async {
    Channel channel =
        await _instance().then((instance) => instance.subscribe(channelName));

    String eventNamePrefixed = 'App\\Events\\$eventName';

    channel.bind(eventNamePrefixed, onEvent);
  }

  @override
  Future<void> close({String? channelName}) async {
    PusherClient pusher = await _instance();

    if (channelName != null) {
      pusher.unsubscribe(channelName);
    }

    pusher.disconnect();
  }
}

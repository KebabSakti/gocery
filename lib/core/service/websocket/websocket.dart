abstract class Websocket {
  void unSubscribeToChannel({required String channelName});

  void bindChannel({
    required String channelName,
    required String eventName,
    required void Function(dynamic event) onEvent,
  });
}

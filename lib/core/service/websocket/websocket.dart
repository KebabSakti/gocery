abstract class Websocket {
  Future<void> listen({
    required String channelName,
    required String eventName,
    required void Function(dynamic event) onEvent,
  });

  Future<void> close({String? channelName});
}

class WebsocketImpl implements Websocket {
  WebsocketImpl({required this.implementation});

  final Websocket implementation;

  @override
  Future<void> close({String? channelName}) async {
    await implementation.close();
  }

  @override
  Future<void> listen(
      {required String channelName,
      required String eventName,
      required void Function(dynamic event) onEvent}) async {
    await implementation.listen(
        channelName: channelName, eventName: eventName, onEvent: onEvent);
  }
}

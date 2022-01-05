import 'package:get/get.dart';

abstract class RequestInterface {
  Future<dynamic> get(String path, {Map<String, String?>? query});

  Future<dynamic> post(String path, {required Map<String, String?>? data});
}

abstract class UploadInterface {
  Future<dynamic> upload(String path, {required FormData formData});
}

abstract class DownloadInterface {
  Future<dynamic> download(String path, {String? savePath});
}

abstract class Network
    implements RequestInterface, UploadInterface, DownloadInterface {
  Future<Network> init();
}

class NetworkImpl implements Network {
  NetworkImpl(this.client);

  final Network client;

  @override
  Future<Network> init() async {
    return await client.init();
  }

  @override
  Future get(String path, {Map<String, String?>? query}) async {
    return await init().then((instance) async => await instance.get(path));
  }

  @override
  Future post(String path, {required Map<String, String?>? data}) async {
    return await init()
        .then((instance) async => await instance.post(path, data: data));
  }

  @override
  Future download(String path, {String? savePath}) async {
    return await init().then((instance) async => await instance.download(path));
  }

  @override
  Future upload(String path, {required FormData formData}) async {
    return await init().then(
        (instance) async => await instance.upload(path, formData: formData));
  }
}

abstract class Storage {
  Future<dynamic> read({required String key});

  Future<void> write({required String key, required String value});

  Future<void> delete({required String key});

  Future<void> deleteAll({required String key});
}

class StorageImpl implements Storage {
  StorageImpl(this.storage);

  final Storage storage;

  @override
  Future<dynamic> read({required String key}) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll({required String key}) async {
    await storage.deleteAll(key: key);
  }
}

class SecureStorageImpl extends StorageImpl {
  SecureStorageImpl(Storage storage) : super(storage);
}

class LocalStorageImpl extends StorageImpl {
  LocalStorageImpl(Storage storage) : super(storage);
}

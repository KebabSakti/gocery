class Fc {
  final String _token = '';

  Fc._create() {
    _token;
  }

  static Future<Fc> create() async {
    var component = Fc._create();

    await Future.delayed(const Duration(seconds: 1));

    return component;
  }
}

void asd() async {
  // Fc a = await Fc.create();
}

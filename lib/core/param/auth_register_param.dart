class AuthRegisterParam {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? token;

  AuthRegisterParam({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.token,
  });

  AuthRegisterParam copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? token,
  }) =>
      AuthRegisterParam(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        token: token ?? this.token,
      );
}

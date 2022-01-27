class AuthenticationRegisterParam {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;

  AuthenticationRegisterParam({
    this.name,
    this.email,
    this.phone,
    this.password,
  });

  AuthenticationRegisterParam copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) =>
      AuthenticationRegisterParam(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );
}

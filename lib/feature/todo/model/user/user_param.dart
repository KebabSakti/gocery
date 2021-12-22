class UserRegisterParam {
  final String? name;
  final String? email;
  final String? password;
  final int? age;

  UserRegisterParam({
    this.name,
    this.email,
    this.password,
    this.age,
  });

  UserRegisterParam copyWith({
    String? name,
    String? email,
    String? password,
    int? age,
  }) =>
      UserRegisterParam(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        age: age ?? this.age,
      );
}

class UserLoginParam {
  final String email;
  final String password;

  UserLoginParam({
    required this.email,
    required this.password,
  });

  UserLoginParam copyWith({
    String? email,
    String? password,
  }) =>
      UserLoginParam(
        email: email ?? this.email,
        password: password ?? this.password,
      );
}

class UserRegisterParam {
  final String? name;
  final String? email;
  final String? password;

  UserRegisterParam({
    this.name,
    this.email,
    this.password,
  });

  UserRegisterParam copyWith({
    String? name,
    String? email,
    String? password,
  }) =>
      UserRegisterParam(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );
}

class UserLoginParam {
  final String? email;
  final String? password;

  UserLoginParam({
    this.email,
    this.password,
  });

  UserLoginParam copyWith({
    String? email,
    String? password,
    int? firebaseToken,
  }) =>
      UserLoginParam(
        email: email ?? this.email,
        password: password ?? this.password,
      );
}

class PhoneLoginParam {
  final String? phoneNumber;
  final String? verificationId;
  final int? resendToken;

  PhoneLoginParam({
    this.phoneNumber,
    this.verificationId,
    this.resendToken,
  });

  PhoneLoginParam copyWith({
    String? phoneNumber,
    String? verificationId,
    int? resendToken,
  }) =>
      PhoneLoginParam(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationId: verificationId ?? this.verificationId,
        resendToken: resendToken ?? this.resendToken,
      );
}

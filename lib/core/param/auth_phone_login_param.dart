class AuthPhoneLoginParam {
  final String? phoneNumber;
  final String? verificationId;
  final String? otpCode;
  final int? resendToken;

  AuthPhoneLoginParam({
    this.phoneNumber,
    this.verificationId,
    this.otpCode,
    this.resendToken,
  });

  AuthPhoneLoginParam copyWith({
    String? phoneNumber,
    String? verificationId,
    String? otpCode,
    int? resendToken,
  }) =>
      AuthPhoneLoginParam(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationId: verificationId ?? this.verificationId,
        otpCode: otpCode ?? this.otpCode,
        resendToken: resendToken ?? this.resendToken,
      );
}

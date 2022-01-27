class AuthenticationPhoneLoginParam {
  final String? phoneNumber;
  final String? verificationId;
  final String? otpCode;
  final int? resendToken;

  AuthenticationPhoneLoginParam({
    this.phoneNumber,
    this.verificationId,
    this.otpCode,
    this.resendToken,
  });

  AuthenticationPhoneLoginParam copyWith({
    String? phoneNumber,
    String? verificationId,
    String? otpCode,
    int? resendToken,
  }) =>
      AuthenticationPhoneLoginParam(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationId: verificationId ?? this.verificationId,
        otpCode: otpCode ?? this.otpCode,
        resendToken: resendToken ?? this.resendToken,
      );
}

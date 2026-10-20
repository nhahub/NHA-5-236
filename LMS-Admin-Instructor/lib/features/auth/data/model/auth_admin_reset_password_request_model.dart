class ResetPasswordRequestModel {
  final String otp;
  final String newPassword;

  ResetPasswordRequestModel({
    required this.otp,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'new_password': newPassword,
    };
  }

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequestModel(
      otp: json['otp'] ?? '',
      newPassword: json['new_password'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ResetPasswordRequestModel(otp: $otp, newPassword: $newPassword)';
  }
}
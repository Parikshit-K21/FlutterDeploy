
class UserLogin {
  final String? loginId;
  final String? password;
  final DateTime? createDateTime;
  final String? isActive;
  final String? emailAddress;
  final String? mobileNumber;

  UserLogin({
    this.loginId,
    this.password,
    this.createDateTime,
    this.isActive,
    this.emailAddress,
    this.mobileNumber,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      loginId: json['loginId'],
      password: json['password'],
      createDateTime: json['createDateTime'] != null 
          ? DateTime.parse(json['createDateTime']) 
          : null,
      isActive: json['isActive'],
      emailAddress: json['emailAddress'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loginId': loginId,
      'password': password,
      'createDateTime': createDateTime?.toIso8601String(),
      'isActive': isActive,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
    };
  }

  void forEach(void Function(String key, dynamic value) action) {
    toJson().forEach(action);
  }
}
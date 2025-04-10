class SignUpModel {
  final String mobile;
  final String email;
  final bool? agree;
  final String firstName;
  final String lastName;
  final String password;
  final String countryCode;
  final String country;
  final String mobileCode;

  SignUpModel({
    required this.mobile,
    required this.email,
    required this.agree,
    required this.lastName,
    required this.firstName,
    required this.password,
    required this.countryCode,
    required this.country,
    required this.mobileCode,
  });
}

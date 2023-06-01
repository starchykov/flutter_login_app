/// Model [Registration] for used in RegistrationPage

class RegistrationModel {
  final String FIRSTNAME;
  final String LASTNAME;
  final String EMAIL;
  final String PHONE;
  final String PASSWORD;
  final String CONFIRMPASSWORD;
  final String LOGIN;

  const RegistrationModel({
    this.FIRSTNAME = '',
    this.LASTNAME = '',
    this.EMAIL = '',
    this.PHONE = '',
    this.PASSWORD = '',
    this.CONFIRMPASSWORD = '',
    this.LOGIN = '',
});

  RegistrationModel copyWith({
    String? FIRSTNAME,
    String? LASTNAME,
    String? EMAIL,
    String? PHONE,
    String? PASSWORD,
    String? CONFIRMPASSWORD,
    String? LOGIN,
  }) {
    return RegistrationModel(
      FIRSTNAME: FIRSTNAME ?? this.FIRSTNAME,
      LASTNAME: LASTNAME ?? this.LASTNAME,
      EMAIL: EMAIL ?? this.EMAIL,
      PHONE: PHONE ?? this.PHONE,
      PASSWORD: PASSWORD ?? this.PASSWORD,
      CONFIRMPASSWORD: CONFIRMPASSWORD ?? this.CONFIRMPASSWORD,
      LOGIN: LOGIN ?? this.LOGIN,
    );
  }

  @override
  String toString() {
    return 'RegistrationModel{FIRSTNAME: $FIRSTNAME, LASTNAME: $LASTNAME, EMAIL: $EMAIL, PHONE: $PHONE, PASSWORD: $PASSWORD, CONFIRMPASSWORD: $CONFIRMPASSWORD, LOGIN: $LOGIN}';
  }
}

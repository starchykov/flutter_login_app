import 'package:flutter/cupertino.dart';

@immutable
class RegistrationPageState {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;
  final bool inProgress;
  final bool isRequestComplete;
  final bool isError;
  final String errorMessage;

  const RegistrationPageState({
     this.firstName = '',
     this.lastName = '',
     this.email = '',
     this.phone = '',
     this.password = '',
     this.isPasswordHidden = true,
     this.isConfirmPasswordHidden = true,
     this.inProgress = false,
     this.isRequestComplete = false,
     this.isError = false,
     this.errorMessage = '',
  });

  RegistrationPageState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    bool? isPasswordHidden,
    bool? isConfirmPasswordHidden,
    bool? inProgress,
    bool? isRequestComplete,
    bool? isError,
    String? errorMessage,
  }) {
    return RegistrationPageState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      inProgress: inProgress ?? this.inProgress,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isConfirmPasswordHidden: isConfirmPasswordHidden ?? this.isConfirmPasswordHidden,
      isRequestComplete: isRequestComplete ?? this.isRequestComplete,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

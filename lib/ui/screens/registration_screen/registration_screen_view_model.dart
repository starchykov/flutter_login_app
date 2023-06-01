import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_app/domain/entities/registration_model.dart';
import 'package:flutter_login_app/domain/network_client/network_exceptions.dart';
import 'package:flutter_login_app/ui/screens/registration_screen/registration_screen_state.dart';

class RegistrationPageViewModel extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get firstNameController => _firstNameController;

  TextEditingController get lastNameController => _lastNameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get phoneController => _phoneController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get loginController => _loginController;

  TextEditingController get confirmPasswordController => _confirmPassController;

  RegistrationPageState _state = const RegistrationPageState();

  RegistrationPageState get state => _state;

  RegistrationPageViewModel({required this.context}) {
    initialize();
  }

  void initialize() async {}

  Future<void> clearTemporaryData() async {
    // ... //
    Navigator.of(context).pop();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    if (value.length < 3) return 'Username must be at least 3 characters long';
    if (value.length > 15) return 'Username must be less than 15 characters';
    if (!RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(value))
      return 'Username can only contain letters, numbers, and underscores';
    if (value.contains(RegExp(r'\W'))) return 'Username can only contain up to one symbol';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? validateLogin(String? value) {
    if (value == null || value.isEmpty) return 'Login is required';
    if (value.length < 3) return 'Login must be at least 3 characters long';
    if (value.length > 15) return 'Login must be less than 15 characters';
    if (!RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(value)) return 'Login can only contain letters, numbers, and underscores';
    if (value.contains(RegExp(r'\W'))) return 'Login can only contain up to one symbol';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Password must contain at least one uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Password must contain at least one lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Password must contain at least one number';
    if (!RegExp(r'[!@#$&*~]').hasMatch(value)) return 'Password must contain at least one special character (!@#\$&*~)';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm Password is required';
    if (value != _passwordController.text) return 'Confirm Password does not match';
    return null;
  }

  /// This Flutter method is used to show or hide input text in an application.
  /// It utilizes HapticFeedback to create a selection click sound,
  /// and then uses the copyWith() method to update the state of the input text to show or hide it.
  /// After the state has been updated, it calls the notifyListeners() method to notify any listeners of the change.
  void showPassword() {
    HapticFeedback.selectionClick();
    _state = _state.copyWith(isPasswordHidden: !_state.isPasswordHidden);
    notifyListeners();
  }

  /// This Flutter method is used to show or hide input text in an application.
  /// It utilizes HapticFeedback to create a selection click sound,
  /// and then uses the copyWith() method to update the state of the input text to show or hide it.
  /// After the state has been updated, it calls the notifyListeners() method to notify any listeners of the change.
  void showConfirmPassword() {
    HapticFeedback.selectionClick();
    _state = _state.copyWith(isConfirmPasswordHidden: !_state.isConfirmPasswordHidden);
    notifyListeners();
  }

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      String message = 'Form contains invalid fields state';
      return;
    }
    ;

    _state = _state.copyWith(inProgress: true);
    notifyListeners();

    RegistrationModel registrationModel = RegistrationModel(
        CONFIRMPASSWORD: _confirmPassController.text,
        FIRSTNAME: _firstNameController.text,
        LASTNAME: _lastNameController.text,
        EMAIL: _emailController.text,
        PHONE: _phoneController.text,
        LOGIN: _loginController.text,
        PASSWORD: _passwordController.text);

    try {
      // await _loginService.registration(registrationModel: registrationModel);
      _state = _state.copyWith(inProgress: false);
    } on ApiClientException catch (error) {
      String errorToShow = error.message.replaceAll('ERRORMESSAGE:', '');
      _state = _state.copyWith(isRequestComplete: true, isError: true, errorMessage: errorToShow);
      notifyListeners();
    } finally {
      // Do some logic
      _state = _state.copyWith(isRequestComplete: true, inProgress: false);
      notifyListeners();
    }
  }
}

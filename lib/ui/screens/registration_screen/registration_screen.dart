import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/registration_screen/registration_screen_state.dart';
import 'package:flutter_login_app/ui/screens/registration_screen/registration_screen_view_model.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static render() {
    return ChangeNotifierProvider(
      create: (context) => RegistrationPageViewModel(context: context),
      child: const RegistrationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    RegistrationPageViewModel viewModel = context.read<RegistrationPageViewModel>();
    RegistrationPageState state = context.select((RegistrationPageViewModel viewModel) => viewModel.state);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        leading: CupertinoButton(
          minSize: 0,
          padding: EdgeInsets.zero,
          onPressed: viewModel.clearTemporaryData,
          child: const Icon(CupertinoIcons.chevron_back, size: 28),
        ),
        backgroundColor: CupertinoColors.secondarySystemBackground,
        middle: const Text('Registration'),
      ),
      child: state.isRequestComplete ? const _RegistrationResult() : const _RegistrationForm(),
    );
  }
}

class _RegistrationResult extends StatelessWidget {
  const _RegistrationResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegistrationPageState state = context.select((RegistrationPageViewModel viewModel) => viewModel.state);
    return Container(
      padding: const EdgeInsets.all(32.0),
      width: MediaQuery.of(context).size.width,
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            state.isError ? 'Error' : 'User created',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
          state.isError
              ? const Icon(CupertinoIcons.clear_circled, size: 100, color: CupertinoColors.destructiveRed)
              : const Icon(CupertinoIcons.checkmark_seal, size: 100, color: CupertinoColors.activeGreen),
          if (state.isError)
            Column(
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  state.errorMessage,
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _RegistrationForm extends StatelessWidget {
  const _RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegistrationPageViewModel viewModel = context.read<RegistrationPageViewModel>();
    RegistrationPageState state = context.select((RegistrationPageViewModel viewModel) => viewModel.state);
    return Form(
      key: viewModel.formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Center(
              child: Text(
                'Create new account',
                style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
            ),
          ),
          CupertinoFormSection.insetGrouped(
            header: const Text('User information'),
            decoration:
                BoxDecoration(color: CupertinoColors.secondarySystemFill, borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: CupertinoColors.secondarySystemBackground,
            children: <Widget>[
              _FormItem(
                prefix: 'First name',
                controller: viewModel.firstNameController,
                validator: viewModel.validateUsername,
              ),
              _FormItem(
                prefix: 'Last name',
                controller: viewModel.lastNameController,
                validator: viewModel.validateUsername,
              ),
            ],
          ),
          CupertinoFormSection.insetGrouped(
            header: const Text('Contact information'),
            decoration:
                BoxDecoration(color: CupertinoColors.secondarySystemFill, borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: CupertinoColors.secondarySystemBackground,
            children: <Widget>[
              _FormItem(
                prefix: 'Email',
                controller: viewModel.emailController,
                validator: viewModel.validateEmail,
              ),
            ],
          ),
          CupertinoFormSection.insetGrouped(
            header: const Text('Profile security information'),
            decoration:
                BoxDecoration(color: CupertinoColors.secondarySystemFill, borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: CupertinoColors.secondarySystemBackground,
            children: <Widget>[
              _FormItem(
                prefix: 'Login',
                controller: viewModel.loginController,
                validator: viewModel.validateLogin,
              ),
              _FormItem(
                prefix: 'Password',
                suffix: _FormSuffix(action: viewModel.showPassword, isTapped: state.isPasswordHidden),
                isHidden: state.isPasswordHidden,
                controller: viewModel.passwordController,
                validator: viewModel.validatePassword,
              ),
              _FormItem(
                prefix: 'Confirm password',
                suffix: _FormSuffix(action: viewModel.showConfirmPassword, isTapped: state.isConfirmPasswordHidden),
                isHidden: state.isConfirmPasswordHidden,
                controller: viewModel.confirmPasswordController,
                validator: viewModel.validateConfirmPassword,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CupertinoButton.filled(
              onPressed: state.inProgress ? null : viewModel.onSubmit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.inProgress) const CupertinoActivityIndicator(),
                  if (state.inProgress) const SizedBox(width: 4),
                  const Text('Submit'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Caution: By clicking the registration button, you are consenting to provide personal information. Please ensure you trust the website and verify its legitimacy before proceeding. Remember to read the terms and conditions, as well as the privacy policy, to understand how your data will be used and protected.',
              style: CupertinoTheme.of(context)
                  .textTheme
                  .tabLabelTextStyle
                  .merge(const TextStyle(color: CupertinoColors.inactiveGray)),
            ),
          ),
          Container(
            height: 30,
            decoration:  BoxDecoration(
              image: DecorationImage(
                  colorFilter: CupertinoTheme.of(context).brightness == Brightness.light
                      ? const ColorFilter.mode(CupertinoColors.secondarySystemBackground, BlendMode.difference)
                      : null,
                  image: const AssetImage('assets/images/cloud_1.png'),
                  opacity: .5,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormItem extends StatelessWidget {
  const _FormItem({
    Key? key,
    required this.prefix,
    this.suffix,
    this.isHidden = false,
    this.controller,
    this.width,
    required this.validator,
  }) : super(key: key);

  final String prefix;
  final Widget? suffix;
  final bool isHidden;
  final TextEditingController? controller;
  final double? width;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        CupertinoTextFormFieldRow(
          controller: controller,
          placeholder: prefix,
          obscureText: isHidden,
          prefix: IntrinsicWidth(
            stepWidth: width,
            child: Text('$prefix: ', style: const TextStyle(fontWeight: FontWeight.w400)),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => validator(value),
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
        ),
        suffix ?? const SizedBox(),
      ],
    );
  }
}

class _FormSuffix extends StatelessWidget {
  const _FormSuffix({
    Key? key,
    required this.action,
    required this.isTapped,
  }) : super(key: key);

  final Function action;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => action(),
      onLongPressEnd: (_) => action(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.eye_solid,
          size: 16,
          color: CupertinoColors.quaternarySystemFill.withOpacity(isTapped ? 1 : .3),
        ),
      ),
    );
  }
}

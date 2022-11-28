import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/ui/screens/login_screen/login_page_state.dart';
import 'package:flutter_login_app/ui/screens/login_screen/login_page_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginPageViewModel(),
      child: const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 2,
            center: Alignment.centerLeft,
            colors: [
              Color.fromRGBO(135, 177, 238, 1.0),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Spacer(),
            _LoginText(),
            SizedBox(height: 16 * 4),
            _LoginUsername(),
            SizedBox(height: 16),
            _LoginPassword(),
            SizedBox(height: 16),
            _ErrorTitle(),
            SizedBox(height: 16 * 3),
            _LoginButton(),
            SizedBox(height: 16),
            _RegisterButton(),
            Spacer(),
            Align(alignment: Alignment.bottomCenter, child: Text('© 2022 Copyright Starchykov')),
          ],
        ),
      ),
    );
  }
}

class _LoginText extends StatelessWidget {
  const _LoginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sing In',
      style: TextStyle(fontSize: 40, color: CupertinoColors.activeBlue.withOpacity(.6), fontWeight: FontWeight.w700),
    );
    // Container(
    //   height: 180,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       opacity: .2,
    //       image: AssetImage('assets/images/cloud.png'),
    //       alignment: Alignment.centerLeft,
    //       fit: BoxFit.fitHeight,
    //     ),
    //   ),
    // ),
  }
}

class _ErrorTitle extends StatelessWidget {
  const _ErrorTitle({Key? key}) : super(key: key);

  void showCupertinoSnackBar(BuildContext context, {required String error, int durationMillis = 3000}) {
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30,
        left: 8.0,
        right: 8.0,
        child: CupertinoPopupSurface(
          child: Container(
            color: CupertinoColors.destructiveRed,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              error,
              style: const TextStyle(fontSize: 14.0, color: CupertinoColors.white),
            ),
          ),
        ),
      ),
    );
    Future.delayed(Duration(milliseconds: durationMillis), overlayEntry.remove);
    Overlay.of(context)?.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final String error = context.select((LoginPageViewModel value) => value.state.authErrorTitle);
    if (error.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((duration) => showCupertinoSnackBar(context, error: error));
    }
    return SizedBox(
      height: 30,
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              height: 30,
              child: Text(error),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginUsername extends StatelessWidget {
  const _LoginUsername({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginPageViewModel model = context.read<LoginPageViewModel>();
    return CupertinoTextField(
      padding: const EdgeInsets.all(10),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(CupertinoIcons.person_fill, size: 16, color: CupertinoColors.activeBlue.withOpacity(.6)),
      ),
      placeholder: 'Login',
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.activeBlue.withOpacity(.6)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      onChanged: (value) => model.login(value: value),
    );
  }
}

class _LoginPassword extends StatelessWidget {
  const _LoginPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginPageViewModel model = context.read<LoginPageViewModel>();
    return CupertinoTextField(
      padding: const EdgeInsets.all(10),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(CupertinoIcons.lock_fill, size: 16, color: CupertinoColors.activeBlue.withOpacity(.6)),
      ),
      placeholder: 'Password',
      suffix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(CupertinoIcons.eye_solid, size: 16, color: CupertinoColors.activeBlue.withOpacity(.6)),
      ),
      obscureText: true,
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.activeBlue.withOpacity(.6)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      onChanged: (value) => model.password(value: value),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        disabledColor: CupertinoColors.activeBlue.withOpacity(.6),
        onPressed: () {},
        child: const Text('Create an account'),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginPageViewModel model = context.read<LoginPageViewModel>();
    final buttonState = context.select((LoginPageViewModel value) => value.state.loginButtonState);
    Future<void> Function()? onPressLogin =
        buttonState == LoginButtonState.canSubmit ? () => model.onLoginButtonPress(context: context) : null;
    return CupertinoButton(
      color: CupertinoColors.activeBlue,
      disabledColor: CupertinoColors.activeBlue.withOpacity(.5),
      onPressed: onPressLogin,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: model.state.authInProcess,
            child: const CupertinoActivityIndicator(color: CupertinoColors.white),
          ),
          Visibility(
            visible: !model.state.authInProcess,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

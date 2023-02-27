import 'dart:ui';

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
    return GestureDetector(
      onTap: () {},
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/images/background_2.png'),
          ),
        ),
        child: OverflowBox(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.9),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.25, 0.9],
                colors: [Color(0xFF000000), Color(0x2d46a0ff)],
              ),
            ),
            child: CupertinoPageScaffold(
              backgroundColor: Colors.transparent,
              child: Form(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Spacer(),
                        const _LoginText(),
                        const _LoginUsername(),
                        const _LoginPassword(),
                        const _ErrorTitle(),
                        const _LoginButton(),
                        const _RegisterButton(),
                        SizedBox(height: MediaQuery.of(context).size.height * .15),
                        const _LoginPageLogo(),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '© 2022-2023 Copyright Starchykov',
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                        ),
                        // const Warning()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
    return const Text(
      ' ',
      style: TextStyle(fontSize: 55, color: CupertinoColors.white, fontWeight: FontWeight.w700),
    );
  }
}

class _ErrorTitle extends StatelessWidget {
  const _ErrorTitle({Key? key}) : super(key: key);

  void showCupertinoSnackBar(BuildContext context, {required String error, int durationMillis = 3000}) {
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        child: SafeArea(
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
      ),
    );
    Future.delayed(Duration(milliseconds: durationMillis), overlayEntry.remove);
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final String error = context.select((LoginPageViewModel value) => value.state.authErrorTitle);
    if (error.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((duration) => showCupertinoSnackBar(context, error: error));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          if (error.isNotEmpty) const Icon(CupertinoIcons.info_circle_fill, size: 14, color: CupertinoColors.white),
          const SizedBox(width: 4),
          Text(
            error,
            style: const TextStyle(fontSize: 14.0, color: CupertinoColors.white),
          ),
        ],
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
    return Container(
      height: 55.0,
      margin: const EdgeInsets.only(top: 20.0),
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: CupertinoTextField(
            padding: const EdgeInsets.all(10),
            style: const TextStyle(color: CupertinoColors.white),
            placeholderStyle: const TextStyle(color: CupertinoColors.white),
            placeholder: 'Login',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(CupertinoIcons.person_crop_circle_fill, color: CupertinoColors.white),
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(.4),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            onChanged: (value) => model.login(value: value),
          ),
        ),
      ),
    );
  }
}

class _LoginPassword extends StatelessWidget {
  const _LoginPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginPageViewModel viewModel = context.read<LoginPageViewModel>();
    final LoginPageState state = context.select((LoginPageViewModel viewModel) => viewModel.state);
    return Container(
      height: 55.0,
      margin: const EdgeInsets.only(top: 20.0),
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: CupertinoTextField(
            padding: const EdgeInsets.all(10),
            style: const TextStyle(color: CupertinoColors.white),
            placeholderStyle: const TextStyle(color: CupertinoColors.white),
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(CupertinoIcons.lock_circle_fill, color: CupertinoColors.white),
            ),
            obscureText: state.hidePassword,
            placeholder: 'Password',
            suffix: GestureDetector(
              onLongPressStart: (_) => viewModel.showPassword(),
              onLongPressEnd: (_) => viewModel.showPassword(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.eye_solid,
                  size: 16,
                  color: CupertinoColors.white.withOpacity(state.hidePassword ? .6 : .2),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: CupertinoColors.white.withOpacity(.4),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            onChanged: (value) => viewModel.password(value: value),
          ),
        ),
      ),
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
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CupertinoButton(
          disabledColor: CupertinoColors.activeBlue.withOpacity(.6),
          onPressed: () {},
          child: const Text('Create an account'),
        ),
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
    return Container(
      height: 55.0,
      margin: const EdgeInsets.only(top: 30.0),
      child: CupertinoButton(
        color: CupertinoColors.activeBlue,
        disabledColor: CupertinoColors.systemBlue,
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
              child: Row(
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    CupertinoIcons.arrow_right_circle,
                    color: CupertinoColors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginPageLogo extends StatelessWidget {
  const _LoginPageLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cloud_1.png'),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.fitHeight),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'App version 1.0.0',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300, fontSize: 12),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

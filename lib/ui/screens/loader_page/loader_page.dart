import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/ui/screens/loader_page/loader_view_model.dart';
import 'package:provider/provider.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key? key}) : super(key: key);

  static Widget render() => Provider<LoaderViewModel>(
        create: (context) => LoaderViewModel(context: context),
        lazy: false,
        child: const LoaderPage(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CupertinoActivityIndicator()),
    );
  }
}

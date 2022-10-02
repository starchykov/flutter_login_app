import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/application/app_state.dart';
import 'package:flutter_login_app/ui/screens/application/app_view_model.dart';
import 'package:provider/provider.dart';

class MVVMApp extends StatelessWidget {
  const MVVMApp({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => AppViewModel(),
      child: const MVVMApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppViewModel viewModel = context.read<AppViewModel>();
    final AppState state = context.select((AppViewModel viewModel) => viewModel.state);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: state.isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      // supportedLocales: Language.locales,
      routes: viewModel.appNavigation.routes,
      initialRoute: AppNavigationRoutes.loaderWidget,
    );
  }
}

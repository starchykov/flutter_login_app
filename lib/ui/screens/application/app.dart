import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/screens/application/app_state.dart';
import 'package:flutter_login_app/screens/application/app_view_model.dart';
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
    final AppNavigation appNavigation = AppNavigation();
    final AppState state = context.select((AppViewModel viewModel) => viewModel.state);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme:  CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: state.isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      supportedLocales: Language.locales,
      routes: appNavigation.routes,
      initialRoute: AppNavigationRoutes.loaderWidget,
    );
  }
}

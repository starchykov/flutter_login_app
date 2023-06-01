import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/application/app_state.dart';
import 'package:flutter_login_app/ui/screens/application/app_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => AppViewModel(),
      child: const LoginApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppViewModel viewModel = context.read<AppViewModel>();
    final AppState state = context.select((AppViewModel viewModel) => viewModel.state);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(state.locale),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: state.isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      routes: viewModel.appNavigation.routes,
      initialRoute: AppNavigationRoutes.loaderWidget,
    );
  }
}

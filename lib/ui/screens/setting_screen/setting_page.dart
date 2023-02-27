import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/setting_screen/setting_page_state.dart';
import 'package:flutter_login_app/ui/screens/setting_screen/setting_page_view_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => SettingPageViewModel(context: context),
      child: const SettingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingPageViewModel viewModel = context.read<SettingPageViewModel>();
    SettingPageState state = context.select((SettingPageViewModel viewModel) => viewModel.state);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: const Text('Settings'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: viewModel.onLogoutButtonClicked,
          child: const Icon(CupertinoIcons.square_arrow_right),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoSwitch(
              value: state.isDarkTheme,
              onChanged: (value) => viewModel.changeTheme(),
              activeColor: CupertinoColors.activeGreen,
            ),
          ],
        ),
      ),
    );
  }
}

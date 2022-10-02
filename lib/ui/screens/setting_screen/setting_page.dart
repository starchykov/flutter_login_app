import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/setting_screen/setting_page_state.dart';
import 'package:flutter_login_app/ui/screens/setting_screen/setting_page_view_model.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => SettingPageViewModel(),
      child: const SettingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingPageViewModel viewModel = context.read<SettingPageViewModel>();
    SettingPageState state = context.select((SettingPageViewModel viewModel) => viewModel.state);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text('Settings'),
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

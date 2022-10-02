import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/counter_page/counter_page.dart';
import 'package:flutter_login_app/ui/screens/home_page/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget render() => Provider<HomeViewModel>(
        create: (context) => HomeViewModel(context: context),
        child: const HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = context.read<HomeViewModel>();
    return CupertinoTabScaffold(
      tabBuilder: (builder, int) => CounterPage.render(),
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle),
              activeIcon: Icon(CupertinoIcons.person_alt_circle_fill),
              label: 'Contacts'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
              label: 'Chats'),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}

// CupertinoPageScaffold(
// navigationBar:  CupertinoNavigationBar(
// automaticallyImplyLeading: false,
// leading: CupertinoButton(
// padding: EdgeInsets.zero,
// child: const Icon(CupertinoIcons.settings),
// onPressed: () => model.onSettingButtonPressed(),
// ),
// middle: const Text('MVVM architecture'),
// trailing: CupertinoButton(
// padding: EdgeInsets.zero,
// child: const Icon(CupertinoIcons.square_arrow_right),
// onPressed: () async => await model.onLogoutButtonPressed(),
// ),
// ), child: CounterPage.render(),
// );

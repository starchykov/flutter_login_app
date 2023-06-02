import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget render() {
    return Provider<HomeViewModel>(
      create: (context) => HomeViewModel(context: context),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    return CupertinoTabScaffold(
      tabBuilder: (builder, int index) => viewModel.renderScreen(screenIndex: index),
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle),
            activeIcon: Icon(CupertinoIcons.person_alt_circle_fill),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}

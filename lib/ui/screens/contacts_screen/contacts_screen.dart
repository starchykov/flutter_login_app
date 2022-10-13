import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/contacts_screen/contacts_screen_view_model.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (context) => ContactsScreenViewModel(context: context),
      child: const ContactsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        const CupertinoSliverNavigationBar(
          leading: Icon(CupertinoIcons.person_2),
          largeTitle: Text('Contacts'),
          trailing: Icon(CupertinoIcons.add_circled),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(20, (index) => const _ContactsItem()),
          ),
        ),
      ]),
    );
  }
}

class _ContactsItem extends StatelessWidget {
  const _ContactsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Row(
          children: [
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: CupertinoColors.systemFill,
                alignment: Alignment.center,
                child: Text('IS', style: CupertinoTheme.of(context).textTheme.pickerTextStyle),
              ),
            ),
            const SizedBox(width: 16.0),
            const Text('Ivan Starchykov'),
          ],
        ),
        onPressed: () {});
  }
}

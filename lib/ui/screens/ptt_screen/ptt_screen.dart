import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/ptt_screen/ptt_screen_state.dart';
import 'package:flutter_login_app/ui/screens/ptt_screen/ptt_screen_view_model.dart';
import 'package:provider/provider.dart';

class PTT extends StatelessWidget {
  const PTT({Key? key}) : super(key: key);

  static Widget render() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PTTViewModel(),
      child: const PTT(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PTTViewModel viewModel = context.read<PTTViewModel>();
    final PTTState state = context.select((PTTViewModel viewModel) => viewModel.state);
    return Column(
      children: [
        GestureDetector(
          onLongPress: () => viewModel.startListening(),
          onLongPressEnd: (details) => viewModel.stopListening(),
          onForcePressEnd: (details) => viewModel.stopListening(),
          child: Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: state.isRecording ? CupertinoColors.destructiveRed : CupertinoColors.link,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Text(
              'PTT',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
        ),
      ],
    );
  }
}

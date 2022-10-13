import 'package:flutter/material.dart';
import 'package:flutter_login_app/ui/screens/application/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => LoginApp.render();
}
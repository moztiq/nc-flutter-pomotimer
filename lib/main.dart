import 'package:flutter/material.dart';
import 'package:nc_flutter_pomotimer/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFF35237),
      ),
      home: const HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo/presenter/home_screen.dart';
import 'package:flutter_todo/presenter/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling
        ),
        child: MaterialApp(
          title: 'Todo Tutorial',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo/model/login_data.dart';
import 'package:flutter_todo/presenter/bloc/bloc.dart';
import 'package:flutter_todo/presenter/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // "username": "kmeus4",
    // "password": "aUTdmmmbH",
    userNameController.text = 'onlykh';
    passwordController.text = '12345678';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [

            Icon(Icons.check_circle,
              size: 65, color: Theme.of(context).primaryColor,
            ),
            const Text('TODO'),

            Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 12, right: 12, bottom: 12
              ),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: userNameController,
                decoration: InputDecoration(
                  hintText: 'User Name',
                  contentPadding: const EdgeInsets.only(
                    left: 12, top: 14, bottom: 14
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.75),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12
              ),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: const EdgeInsets.only(
                      left: 12, top: 14, bottom: 14
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.75),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 24
              ),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    bloc.loginDate(
                        LoginData(
                          username: userNameController.text,
                          password: passwordController.text
                        )
                    ).then((value) {
                      if(value.token != null){
                        SharedPreferences.getInstance().then((shared) {
                          shared.setString('token', "Bearer ${value.token}");
                        });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("LOGIN",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
              ),
            )
          ],
        )
    );
  }
}

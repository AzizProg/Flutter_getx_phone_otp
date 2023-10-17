import 'login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(188, 48),
      backgroundColor: const Color(0xFF051B8B),
      elevation: 6,
      textStyle: const TextStyle(fontSize: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          )));

   HomePage({super.key});

  void _userHome() async {
    Get.to(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F2B2F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenue!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: style,
                onPressed: _userHome,
                child: const Text(
                  'Faire un test',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}

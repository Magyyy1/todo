import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import 'database/auth.dart';
import 'main.dart';

class AuthPage extends StatefulWidget {
  final PocketBase pb;

  const AuthPage({super.key, required this.pb});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final PocketBaseAuth pocketBaseAuth;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    pocketBaseAuth = PocketBaseAuth(pb: widget.pb);
  }

  void refresh() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MainApp(pb: widget.pb)),
      (route) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  InputDecoration customInputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white70),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TODO',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.yellow,
                  decoration: customInputDecoration(
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  cursorColor: Colors.yellow,
                  decoration: customInputDecoration(
                    hintText: 'Password',
                    icon: Icons.lock,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.yellow),
                    foregroundColor:
                        WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty) {
                      try {
                        await pocketBaseAuth.signIn(
                          emailController.text.trim(),
                          passController.text.trim(),
                        );

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Успешная авторизация'),
                            backgroundColor: Colors.black,
                          ),
                        );

                        refresh();
                      } catch (e) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка входа: $e'),
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Заполните поля'),
                          backgroundColor: Colors.black,
                        ),
                      );
                    }
                  },
                  child: const Text('Войти'),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('У вас нет аккаунта? '),
                  InkWell(
                    child: const Text('Создать'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/reg');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import 'database/auth.dart';
import 'main.dart';

class RegPage extends StatefulWidget {
  final PocketBase pb;

  const RegPage({super.key, required this.pb});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  late final PocketBaseAuth pocketBaseAuth;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController repeatPassController;

  @override
  void initState() {
    super.initState();
    pocketBaseAuth = PocketBaseAuth(pb: widget.pb);
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    repeatPassController = TextEditingController();
  }

  void refresh() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MainApp(pb: widget.pb)),
      (route) => false,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    repeatPassController.dispose();
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
                  controller: nameController,
                  cursorColor: Colors.yellow,
                  decoration: customInputDecoration(
                    hintText: 'Nickname',
                    icon: Icons.person,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: repeatPassController,
                  obscureText: true,
                  cursorColor: Colors.yellow,
                  decoration: customInputDecoration(
                    hintText: 'Repeat password',
                    icon: Icons.lock,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

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
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty &&
                        repeatPassController.text.isNotEmpty) {
                      if (passController.text != repeatPassController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Пароли не совпадают'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        return;
                      }

                      try {
                        await pocketBaseAuth.signUp(
                          emailController.text.trim(),
                          passController.text.trim(),
                          nameController.text.trim(),
                          repeatPassController.text.trim(),
                        );

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Успешная регистрация'),
                            backgroundColor: Colors.black,
                          ),
                        );

                        refresh();
                      } catch (e) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка регистрации: $e'),
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Заполните поля'),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      );
                    }
                  },
                  child: const Text('Создать'),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('У вас есть аккаунт? '),
                  InkWell(
                    child: const Text('Войти'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/auth');
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
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('TODO', style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
            decoration: InputDecoration(hintText: 'Email', 
            border: OutlineInputBorder(borderRadius: 
            BorderRadius.circular(20),
            ))),
            
            const SizedBox(height: 20),
            TextField(obscureText: true, 
            decoration: InputDecoration(hintText: 'Password', 
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            ))),
          

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {}, 
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 252, 255, 59), foregroundColor: Colors.black),
              child: const Text('Войти'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/reg'),
              style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
              child: const Text('Нет аккаунта? Создать'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Регистрация',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                _buildTextField('Имя', Icons.person),
                const SizedBox(height: 15),

                _buildTextField('Никнейм', Icons.alternate_email),
                const SizedBox(height: 15),

                _buildTextField('Емайл', Icons.email),
                const SizedBox(height: 15),

                _buildTextField('Пароль', Icons.lock, isPass: true),
                const SizedBox(height: 15),

                _buildTextField('Повторите пароль', Icons.lock_reset, isPass: true),
                
                const SizedBox(height: 40),
                
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {

                    },
                    child: const Text('Зарегистрироваться', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.yellow),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'reg.dart';
late PocketBase pb;
void main() async {
WidgetsFlutterBinding.ensureInitialized();

final prefs = await SharedPreferences.getInstance();
final store = AsyncAuthStore(
  save: (String data)async => prefs.setString('pb_auth', data),
  initial: prefs.getString('pb_auth'),);

  pb = PocketBase("http://127.0.0.1:8090", authStore: store);
  runApp(MainApp(pb: pb));
}

class MainApp extends StatelessWidget {
  final PocketBase pb;
  const MainApp({super.key, required this.pb});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/reg': (context) => const RegPage(),
      },
    );
  }
}
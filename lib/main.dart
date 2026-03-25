import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import 'auth.dart';
import 'reg.dart';
import 'home.dart';

late final PocketBase pb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final store = AsyncAuthStore(
    save: (String data) async {},
    initial: '',
  );

  pb = PocketBase(
    'http://10.0.2.2:8090',
    authStore: store,
  );

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
      home: pb.authStore.isValid ? HomePage(pb: pb) : AuthPage(pb: pb),
      routes: {
        '/auth': (context) => AuthPage(pb: pb),
        '/reg': (context) => RegPage(pb: pb),
      },
    );
  }
}
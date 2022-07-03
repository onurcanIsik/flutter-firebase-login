import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/firebase_options.dart';
import 'package:loginfirebase/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginFirebase(),
  ));
}

class LoginFirebase extends StatefulWidget {
  const LoginFirebase({Key? key}) : super(key: key);

  @override
  State<LoginFirebase> createState() => _LoginFirebaseState();
}

class _LoginFirebaseState extends State<LoginFirebase> {
  @override
  Widget build(BuildContext context) {
    return const RegisterPage();
  }
}

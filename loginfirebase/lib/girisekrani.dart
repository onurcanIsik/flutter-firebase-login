import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginfirebase/homepage.dart';
import 'package:loginfirebase/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, sifre;

  // doğrulama anahtarı

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return value!.contains("@") ? null : "Geçersiz E-mail";
                },
                onChanged: (alinanEmail) {
                  email = alinanEmail;
                },
                decoration: const InputDecoration(
                  labelText: "e-mail",
                  hintText: "example@gmail.com",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                  return value!.length >= 6 ? null : "Geçersiz şifre";
                },
                onChanged: (alinanSifre) {
                  sifre = alinanSifre;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "şifre",
                  hintText: "************",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    girisYap();
                  },
                  child: const Text("Giriş"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              child: const Text(
                "Hesabım yok",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }

  void girisYap() {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}

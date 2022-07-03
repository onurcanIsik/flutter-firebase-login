// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginfirebase/girisekrani.dart';
import 'package:loginfirebase/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Kayıt Paremetre
  late String email, sifre;

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (alinanEmail) {
                  setState(() {
                    email = alinanEmail;
                  });
                },
                validator: (alinanMail) {
                  return alinanMail!.contains("@") ? null : "Mail Geçersiz";
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "e-mail",
                  hintText: "example@gmail.com",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (alinanSifre) {
                  setState(() {
                    sifre = alinanSifre;
                  });
                },
                validator: (alinanSifre) {
                  return alinanSifre!.length >= 6
                      ? null
                      : "Daha uzun bir şifre giriniz";
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Şifre",
                  hintText: "**************",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    kayitOl();
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text(
                "Zaten bir hesabınız mı var ?",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }

  void kayitOl() {
    if (_globalKey.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then(
        (user) {
          //Başarılı ise burası
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
        },
      ).catchError(
        (hata) {
          //Başarısız ise burası

          Fluttertoast.showToast(msg: hata);
        },
      );
    }
  }
}

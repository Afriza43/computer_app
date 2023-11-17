import 'dart:convert';
import 'package:computer_app/bottom_nav.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const BottomNavigation();
      }));
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 62),
            Lottie.asset(
              "./assets/lottie/pc.json",
              width: 300,
              height: 250,
            ),
            Text(
              "Selamat Datang",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                String username = _username.text;
                String password = _password.text;

                if (username != "" && password == "123") {
                  var bytes = utf8.encode(password);
                  var sha = sha256.convert(bytes);

                  print("Original : $password");
                  print("Hash : $sha");

                  logindata.setBool("login", false);
                  logindata.setString("username", username);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const BottomNavigation();
                  }));
                }
              },
              child: Text(
                "Login",
                style: GoogleFonts.poppins(),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Buat Akun",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

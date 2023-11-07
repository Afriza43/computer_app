import 'package:computer_app/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Implementasi logika login di sini
    String email = _emailController.text;
    String password = _passwordController.text;

    // Contoh: validasi email dan password
    if (email == "user" && password == "123") {
      // Berhasil login
      print("Login berhasil");

      // Redirect ke halaman lain (contoh: homepage)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              HomePage(), // Ganti dengan widget homepage yang sesuai
        ),
      );
    } else {
      // Tampilkan pesan kesalahan atau tindakan lain
      print("Login gagal");
    }
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
              SizedBox(height: 62),
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: GoogleFonts.poppins(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: GoogleFonts.poppins(),
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Hapus controller ketika widget di-dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

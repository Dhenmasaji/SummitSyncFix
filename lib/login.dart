import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_akhir_tpm/register.dart';
import 'package:tugas_akhir_tpm/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart' as crypto;

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Username/Password is empty'),
        ),
      );
    } else if (email == 'admin' && password == 'admin') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);

      // Encrypt password before printing it to the terminal
      final encryptedPassword = _encryptPassword(password);
      print('Encrypted Password: $encryptedPassword');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red, // Red snackbar
          content: Text('Wrong Username/Password'),
        ),
      );
    }
  }

  
  String _encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hashedPassword = crypto.sha256.convert(bytes);
    return hashedPassword.toString();
    final encryptedPassword = _encryptPassword(password);
    print('Encrypted Password: $encryptedPassword');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 200,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Login',
                style: GoogleFonts.poppins(
                    fontSize: 38, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
              Text(
                'Silahkan login untuk memulai aplikasi dengan akun yang telah terdaftar',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Aksi ketika tombol forgot password ditekan
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(color: Colors.orange),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color(0xFF004A3C),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color(0xFFFEAA45),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'OR Login With',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                      icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/120px-Google_%22G%22_logo.svg.png?20230822192911'),
                      ),
                      onPressed: () {
                        // Aksi ketika ikon Google ditekan
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                      icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.network(
                            'https://cdn.cms-twdigitalassets.com/content/dam/about-twitter/x/brand-toolkit/logo-black.png.twimg.2560.png'),
                      ),
                      onPressed: () {
                        // Aksi ketika ikon Facebook ditekan
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                      icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png?20220821121934'),
                      ),
                      onPressed: () {
                        // Aksi ketika ikon Apple ditekan
                      },
                    ),
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

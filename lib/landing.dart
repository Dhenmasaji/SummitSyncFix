import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/register.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // Replace SingleChildScrollView with Container
        height: double.infinity, // Set height to infinity
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              // Gambar ilustrasi
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 400,
                ),
              ),
              SizedBox(height: 40),
              // Tulisan welcome dan deskripsi
              Text(
                'Welcome',
                style: GoogleFonts.poppins(fontSize: 38, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
              Text(
                'Selamat datang di aplikasi kami. Silakan login atau register untuk melanjutkan.',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 30),
              // Button Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Login',style: GoogleFonts.poppins(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Border radius kecil
                    ),
                    backgroundColor: Color(0xFF004A3C), // Warna latar belakang #004A3C
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Button Register
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text('Register', style: GoogleFonts.poppins(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Border radius kecil
                    ),
                    backgroundColor: Color(0xFFFEAA45), // Warna latar belakang #FEAA45
                  ),
                ),
              ),
              SizedBox(height: 25),
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
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
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
              // Ikon sosial media
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
                        child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/120px-Google_%22G%22_logo.svg.png?20230822192911'),
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
                        child: Image.network('https://cdn.cms-twdigitalassets.com/content/dam/about-twitter/x/brand-toolkit/logo-black.png.twimg.2560.png'),
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
                        child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/800px-Apple_logo_black.svg.png?20220821121934'),
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

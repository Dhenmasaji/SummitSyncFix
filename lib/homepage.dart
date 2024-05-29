import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/saran.dart';
import 'package:tugas_akhir_tpm/myapp.dart';
import 'package:tugas_akhir_tpm/detail_pendaki.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  void _navigateTo(int index) {
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaranPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyappPage()),
        );
        break;
      case 3:
        _showLogoutConfirmation();
        break;
    }
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('loggedIn', false);
                await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                "Yes",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: GoogleFonts.poppins(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF004A3C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF004A3C),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/profile.jpeg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ravi Aprillian Baskoro',
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
                style: GoogleFonts.poppins(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.sticky_note_2),
              title: Text(
                'Saran & Kesan',
                style: GoogleFonts.poppins(),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.hiking),
              title: Text(
                'SummitSync',
                style: GoogleFonts.poppins(),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(3);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPendakiPage()),
                    );
                  },
                  child: Text(
                    'Data Pendaki',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

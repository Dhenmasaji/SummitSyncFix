import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/saran.dart';
import 'package:tugas_akhir_tpm/myapp.dart';
import 'package:tugas_akhir_tpm/detail_pendaki.dart';
import 'package:tugas_akhir_tpm/timezone.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _currentTime = '--:--:--';

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              _currentTime = _getCurrentTime();
            }));
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutConfirmation();
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SaranPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyappPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26.0,
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                    ),
                    SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ravi Aprillian Baskoro',
                          style: GoogleFonts.poppins(fontSize: 14.0),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimezoneSettings()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: GoogleFonts.poppins(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 200),
                  Text(
                    _currentTime,
                    style: GoogleFonts.poppins(fontSize: 14.0),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/c1.JPG'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/c2.jpg'), // Change image path as needed
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Add some space between the rectangles
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/c3.jpg'), // Change image path as needed
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Allow me to introduce myself, I am Ravi Aprillian Baskoro, a 6th-semester student majoring in Informatics Engineering at UPN Veteran Yogyakarta. I am a passionate Flutter developer who enjoys crafting elegant and practical mobile applications. ',
                style: GoogleFonts.poppins(fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
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
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF004A3C),
              icon: CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/c2.jpg'),
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF004A3C),
              icon: Icon(Icons.sticky_note_2),
              label: 'Saran & Kesan',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF004A3C),
              icon: Icon(Icons.hiking),
              label: 'SummitSync',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF004A3C),
              icon: Icon(Icons.logout_outlined),
              label: 'Logout',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          selectedLabelStyle: GoogleFonts.poppins(),
          unselectedLabelStyle: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

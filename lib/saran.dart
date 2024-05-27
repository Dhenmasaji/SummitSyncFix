import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/homepage.dart';
import 'package:tugas_akhir_tpm/myapp.dart';

class SaranPage extends StatefulWidget {
  @override
  _SaranPageState createState() => _SaranPageState();
}

class _SaranPageState extends State<SaranPage> {
  int _selectedIndex = 1; // Index of the selected tab


  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutConfirmation();
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }else if (index == 2) {
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
          backgroundColor: Colors.white, // Set background color to white
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(
              fontSize: 26, // Set font size to 20
              fontWeight: FontWeight.w600, // Set font weight to bold
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: GoogleFonts.poppins(), // Apply Poppins font to content
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
                  color: Colors.red, // Set text color to red
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
                  color: Colors.green, // Set text color to green
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
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
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
                    'Saran & Kesan',
                    style: GoogleFonts.poppins(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Mata Kuliah Pemrograman Teknologi Mobile memberikan pengalaman belajar yang berharga bagi saya dalam memahami dasar-dasar pemrograman Android. Materi yang disampaikan relevan dengan kebutuhan industri saat ini dan membantu saya mengembangkan kemampuan yang dibutuhkan untuk menjadi programmer mobile yang sukses.Dosen mata kuliah ini sangat kompeten di bidangnya dan mampu menjelaskan materi dengan jelas dan mudah dipahami. Beliau juga inspiratif dan mendorong saya untuk terus belajar dan berkembang. Suasana belajar di kelas sangat kondusif dan memungkinkan saya untuk fokus belajar dan berdiskusi dengan teman-teman sekelas yang suportif dan saling membantu.Untuk saran mata kuliah ini, menurut saya tidak ada saran yang signifikan, cukup sama seperti ini sudah membuat mahasiswa dapat mengikuti perkuliahan dengan baik',
                style: GoogleFonts.poppins(fontSize: 16.0),
                textAlign: TextAlign.justify,
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
              icon: Icon(Icons.person),
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

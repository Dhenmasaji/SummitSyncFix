import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_tpm/detail_pendaki.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/myapp.dart';
import 'package:tugas_akhir_tpm/setting.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> mountains = [
    {
      "name": "Mount Merapi",
      "height": "2,930 meters",
      "image": "assets/merapi.jpg"
    },
    {
      "name": "Mount Sumbing",
      "height": "3,371 meters",
      "image": "assets/sumbing.jpg"
    },
    {
      "name": "Mount Semeru",
      "height": "3,676 meters",
      "image": "assets/semeru.jpg"
    },
    {
      "name": "Mount Gede",
      "height": "2,958 meters",
      "image": "assets/gede.jpg"
    },
    {
      "name": "Mount Sindoro",
      "height": "3,150 meters",
      "image": "assets/sindoro.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/hd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 38.0,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            SizedBox(height: 10),
            Text(
              'Ravi Aprillian Baskoro',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Summit Sync App',
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text(
          'Homepage',
          style: GoogleFonts.poppins(),
        ),
      ),
      ListTile(
        leading: Icon(Icons.sticky_note_2),
        title: Text(
          'Data Pendaki',
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
      Divider(), // Add a divider
      ListTile(
        leading: Icon(Icons.settings), // Icon for the setting menu
        title: Text(
          'Settings', // Text for the setting menu
          style: GoogleFonts.poppins(),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingPage()), // Navigate to SettingPage
          );
        },
      ),
      Expanded(child: SizedBox()), // Add expanded SizedBox to push Logout to the bottom
      ListTile(
        leading: Icon(Icons.logout_outlined),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(),
        ),
        onTap: () {
          Navigator.pop(context);
          _navigateTo(4);
        },
      ),
    ],
  ),
),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 28.0, 0.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          iconSize: 30,
                        ),
                      ),
                      CircleAvatar(
                        radius: 24.0,
                        backgroundImage: AssetImage('assets/profile.jpeg'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Find your",
                      style: GoogleFonts.bitter(
                          fontSize: 34, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "perfect ways",
                      style: GoogleFonts.bitter(
                          fontSize: 34, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 10),
                    child: Text(
                      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 220,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 5,
                                child: Image.asset(
                                  'assets/merbabu.jpg', // Replace with your image
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 8,
                                bottom: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 0),
                                      child: Text(
                                        'Mount Merbabu',
                                        style: GoogleFonts.bitter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 0),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        '3.145 meters',
                                        style: GoogleFonts.bitter(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 18),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 220,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 5,
                                child: Image.asset(
                                  'assets/lawu.jpg', // Replace with your image
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 8,
                                bottom: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 0),
                                      child: Text(
                                        'Mount Lawu',
                                        style: GoogleFonts.bitter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 0),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        '3.265 meters',
                                        style: GoogleFonts.bitter(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Top Destination",
                      style: GoogleFonts.bitter(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: mountains.length,
                  itemBuilder: (context, index) {
                    final mountain = mountains[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0), // Padding only left for the card
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.grey.shade300, // Warna border
                                  width: 1.0, // Ketebalan border
                                ),
                              ),
                              height: 90,
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(mountain['image']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            mountain['name']!,
                                            style: GoogleFonts.bitter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            mountain['height']!,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _navigateTo(3);
                                },
                                style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFF004A3C), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  ),
                                ),
                              ),
                                child: Text(
                                  'Reserve',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(int index) {
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPendakiPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyappPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyappPage()),
        );
        break;
      case 4:
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
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/homepage.dart';
import 'package:tugas_akhir_tpm/saran.dart';
import 'package:tugas_akhir_tpm/myapp_detail.dart';

class MyappPage extends StatefulWidget {
  @override
  _MyappPageState createState() => _MyappPageState();
}

class _MyappPageState extends State<MyappPage> {
  int _selectedIndex = 2; 
  List<dynamic> volcanoData = []; 
  List<dynamic> filteredVolcanoData = []; 
  TextEditingController searchController = TextEditingController(); 
  String searchQuery = ''; 

  @override
  void initState() {
    super.initState();
    fetchVolcanoData();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        filterVolcanoData();
      });
    });
  }

  void fetchVolcanoData() async {
    try {
      final response = await http.get(
          Uri.parse('https://taksakaa.github.io/volcano_api/volcano.json'));

      if (response.statusCode == 200) {
        setState(() {
          volcanoData = json.decode(response.body);
          filteredVolcanoData = volcanoData; // Initialize filtered data
        });
      } else {
        throw Exception('Failed to load volcano data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterVolcanoData() {
    setState(() {
      if (searchQuery.isEmpty) {
        filteredVolcanoData = volcanoData;
      } else {
        filteredVolcanoData = volcanoData
            .where((volcano) => volcano['nama']
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutConfirmation();
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SaranPage()),
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
          padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/logo.png'),
                      width: 52.0,
                      height: 52.0,
                    ),
                    SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summit Sync',
                          style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'A Reservation Mountain app',
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
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry Lorem Ipsum is',
                style: GoogleFonts.poppins(fontSize: 12.0),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 15),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search Volcano Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 1.0, // Aspect ratio of each grid item
                  ),
                  itemCount: filteredVolcanoData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredVolcanoData[index]['nama'],
                                style: GoogleFonts.poppins(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Bentuk: ${filteredVolcanoData[index]['bentuk']}',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Tinggi: ${filteredVolcanoData[index]['tinggi_meter']}',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              // Add more details if needed
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyappDetailPage(
                                      volcanoName: filteredVolcanoData[index]
                                          ['nama'],
                                    ),
                                  ),
                                );
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
                                    color: Colors.white), // Text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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

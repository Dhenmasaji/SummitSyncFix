import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_tpm/login.dart';
import 'package:tugas_akhir_tpm/saran.dart';
import 'package:tugas_akhir_tpm/detail_pendaki.dart';
import 'package:tugas_akhir_tpm/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyappDetailPage extends StatefulWidget {
  @override
  _MyappDetailPageState createState() => _MyappDetailPageState();
  final String volcanoName;
  MyappDetailPage({required this.volcanoName});
}

class _MyappDetailPageState extends State<MyappDetailPage> {
  int _selectedIndex = 2; // Index of the selected tab

  List<dynamic> volcanoData = [];
  DateTime? selectedDate;
  DateTime? selectedDate2; // List to hold fetched volcano data

  // Controllers for each TextFormField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _dateUpController = TextEditingController();
  final TextEditingController _dateDownController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVolcanoData(); // Call function to fetch volcano data when the widget initializes
  }

  void fetchVolcanoData() async {
    try {
      final response = await http.get(
          Uri.parse('https://taksakaa.github.io/volcano_api/volcano.json'));

      if (response.statusCode == 200) {
        setState(() {
          volcanoData = json
              .decode(response.body); // Decode JSON response and store in list
        });
      } else {
        throw Exception('Failed to load volcano data');
      }
    } catch (e) {
      print('Error: $e');
    }
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

  bool validateForm() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _groupController.text.isNotEmpty &&
        _dateUpController.text.isNotEmpty &&
        _dateDownController.text.isNotEmpty;
  }

  void showValidationError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(
                Icons.wrong_location,
                color: Colors.red, //
              ),
              SizedBox(width: 8),
              Text('Error'),
            ],
          ),
          content: Text('Please fill in all the required fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showSuccessMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 8),
              Text('Reservasi Berhasil'),
            ],
          ),
          content: Text('Reservasi Anda telah berhasil diproses.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailPendakiPage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _saveDataToLocalDatabase() async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil data yang ada
    String? existingData = prefs.getString('pendakiList');
    List<dynamic> pendakiList = existingData != null ? json.decode(existingData) : [];

    // Tambahkan data baru
    Map<String, dynamic> newPendaki = {
      'namaKetua': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'jumlahRombongan': int.parse(_groupController.text),
      'tanggalNaik': _dateUpController.text,
      'tanggalTurun': _dateDownController.text,
    };
    pendakiList.add(newPendaki);

    // Simpan kembali data yang diperbarui
    prefs.setString('pendakiList', json.encode(pendakiList));
  }

  void _onSubmitButtonPressed() {
    if (validateForm()) {
      _saveDataToLocalDatabase(); // Simpan data ke dalam local database
      showSuccessMessage(); // Tampilkan pesan sukses
    } else {
      showValidationError(); // Tampilkan pesan validasi error
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 44.0, 28.0, 0.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Reservation Page',
                        style: GoogleFonts.poppins(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ), // Adjust spacing as needed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Gunung ${widget.volcanoName}', // Display volcano name here
                        style: GoogleFonts.poppins(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1.0,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Silakan isi formulir berikut untuk melakukan reservasi pendakian. Pastikan semua data diisi dengan benar.',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Ketua Rombongan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'No Handphone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _groupController,
                    decoration: InputDecoration(
                      labelText: 'Jumlah Rombongan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _dateUpController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Naik',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                    _dateUpController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate!);
                                  });
                                }
                              },
                              icon: Icon(Icons.date_range_outlined),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _dateDownController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Turun',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final DateTime? pickedDate2 =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate2 != null) {
                                  setState(() {
                                    selectedDate2 = pickedDate2;
                                    _dateDownController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate2!);
                                  });
                                }
                              },
                              icon: Icon(Icons.date_range_outlined),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSubmitButtonPressed,
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 6, 53, 35),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16.0,
              left: 16.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Navigasi kembali ke halaman sebelumnya
                },
              ),
            ),
          ],
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

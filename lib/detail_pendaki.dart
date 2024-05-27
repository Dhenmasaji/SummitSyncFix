import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_akhir_tpm/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailPendakiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: FutureBuilder(
              future: _getPendakiData(),
              builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 38.0, 16.0, 8.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              'No Data Available',
                              style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  final data = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 38.0, 16.0, 8.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              'Data Reservasi Pendaki',
                              style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ListTile(
                                      title: Text(
                                        '${data[index]['namaKetua']}',
                                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Email: ${data[index]['email']}'),
                                          Text('No HP: ${data[index]['phone']}'),
                                          Text('Jumlah Rombongan: ${data[index]['jumlahRombongan']}'),
                                          Text('Tanggal Naik: ${data[index]['tanggalNaik']}'),
                                          Text('Tanggal Turun: ${data[index]['tanggalTurun']}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.orange,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.white,
                                            onPressed: () {
                                              // Aksi yang diambil ketika tombol delete ditekan
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: const Color.fromARGB(255, 0, 74, 60),
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.payment),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PaymentPage(
                                                    pendakiData: data[index],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getPendakiData() async {
    final prefs = await SharedPreferences.getInstance();
    String? pendakiListString = prefs.getString('pendakiList');

    if (pendakiListString != null) {
      List<dynamic> pendakiList = json.decode(pendakiListString);
      return pendakiList.map((item) => item as Map<String, dynamic>).toList();
    } else {
      return [];
    }
  }
}

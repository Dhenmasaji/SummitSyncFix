import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> pendakiData;
  final int ticketPrice = 25000; // Harga tiket per orang

  PaymentPage({required this.pendakiData});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedCurrency = 0;
  double eurToIdrRate = 0;
  double usdToIdrRate = 0;
  double gbpToIdrRate = 0;

  @override
  void initState() {
    super.initState();
    fetchEurToIdrRate();
    fetchUsdToIdrRate();
    fetchGbpToIdrRate();
  }

  Future<void> fetchEurToIdrRate() async {
    final response = await http.get(Uri.parse(
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.json'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        eurToIdrRate = data['eur']['idr'];
      });
    }
  }

  Future<void> fetchUsdToIdrRate() async {
    final response = await http.get(Uri.parse(
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        usdToIdrRate = data['usd']['idr'];
      });
    }
  }

  Future<void> fetchGbpToIdrRate() async {
    final response = await http.get(Uri.parse(
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/gbp.json'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        gbpToIdrRate = data['gbp']['idr'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int jumlahRombongan =
        int.parse(widget.pendakiData['jumlahRombongan'].toString());
    int totalPrice = jumlahRombongan * widget.ticketPrice;

    List<DropdownMenuItem<int>> _currencyItems = [
      DropdownMenuItem(
        child: Text('IDR (Rp)'),
        value: 0,
      ),
      DropdownMenuItem(
        child: Text('EUR (€)'),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text('USD (\$)'),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text('GBP (£)'),
        value: 3,
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
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
              ],
            ),
            Divider(
              thickness: 1.0,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('assets/profile.jpeg'),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.pendakiData['namaKetua']}',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.pendakiData['email']}',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Nama Ketua     ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(widget.pendakiData['namaKetua'],
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Email      ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(widget.pendakiData['email'],
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('No Handphone     ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(widget.pendakiData['phone'],
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Jumlah Pendaki     ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('$jumlahRombongan',
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Tanggal Naik     ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(widget.pendakiData['tanggalNaik'],
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Tanggal Turun      ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(widget.pendakiData['tanggalTurun'],
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1.0,
            ),
            SizedBox(height: 10),
            Text(
              'Payment Details',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Harga Tiket: ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('Rp. ${widget.ticketPrice}',
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Total Harga: ',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('Rp. $totalPrice',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1.0,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Select Currency',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedCurrency,
                    items: _currencyItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedCurrency = value!;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius:
                            BorderRadius.circular(12), // tambahkan ini
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius:
                            BorderRadius.circular(12), // tambahkan ini
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Menempatkan elemen di ujung kiri dan kanan
              children: [
                Text(
                  'Total Payment: ',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Menempatkan elemen ke ujung kanan
                    children: [
                      if (_selectedCurrency == 0)
                        Text('Rp ${(totalPrice)}',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      if (_selectedCurrency == 1)
                        Text(
                            '${(totalPrice / eurToIdrRate).toStringAsFixed(2)} EUR',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      if (_selectedCurrency == 2)
                        Text(
                            '${(totalPrice / usdToIdrRate).toStringAsFixed(2)} USD',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      if (_selectedCurrency == 3)
                        Text(
                            '${(totalPrice / gbpToIdrRate).toStringAsFixed(2)} GBP',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 175),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add payment processing logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text('Payment Successful')
                    ),
                  );
                },
                child: Text(
                  'Pay Now',
                  style: GoogleFonts.poppins(color: Colors.white,),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Color.fromARGB(255, 0, 74, 63),
                  minimumSize:
                      Size(double.infinity, 0), // Membuat lebar selebar layar
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(color: Colors.white,),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.orange,
                  minimumSize:
                      Size(double.infinity, 0), // Membuat lebar selebar layar
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

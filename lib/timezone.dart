import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class TimezoneSettings extends StatefulWidget {
  @override
  _TimezoneSettingsState createState() => _TimezoneSettingsState();
}

class _TimezoneSettingsState extends State<TimezoneSettings> {
  String _selectedTimezone = 'UTC';
  List<String> _timezones = [];
  Timer? _timer;
  DateTime _currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    tz_data.initializeTimeZones();
    _timezones = tz.timeZoneDatabase.locations.keys.toList();
    _timezones.sort();
    _loadTimezone();
    _startClock();
  }

  Future<void> _loadTimezone() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTimezone = prefs.getString('selectedTimezone') ?? 'UTC';
    });
  }

  Future<void> _setTimezone(String timezone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTimezone', timezone);
    setState(() {
      _selectedTimezone = timezone;
    });
  }

  void _startClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _currentDateTime = DateTime.now();
      });
    });
  }

  DateTime _getCurrentTimeForSelectedTimezone() {
    final location = tz.getLocation(_selectedTimezone);
    final now = tz.TZDateTime.now(location);
    return now;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = _getCurrentTimeForSelectedTimezone();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timezone Settings',
          style: GoogleFonts.poppins(fontSize: 20.0),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Selected Timezone',
              style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTimezone,
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
                Text(
                  '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}',
                  style: GoogleFonts.poppins(fontSize: 14.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _timezones.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _timezones[index],
                    style: GoogleFonts.poppins(fontSize: 14.0),
                  ),
                  trailing: _selectedTimezone == _timezones[index]
                      ? Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () => _setTimezone(_timezones[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TimezoneSettings(),
  ));
}

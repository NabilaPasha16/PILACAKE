import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String email;
  const ProfilePage({super.key, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = {};
  bool _loadingDevice = true;

  @override
  void initState() {
    super.initState();
    _initDeviceInfo();
  }

  Future<void> _initDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        setState(() => _deviceData = _readAndroidBuildData(info));
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        setState(() => _deviceData = _readIosDeviceInfo(info));
      } else {
        final info = await _deviceInfo.deviceInfo;
        setState(() => _deviceData = info.data);
      }
      setState(() => _loadingDevice = false);
    } catch (e) {
      setState(() {
        _deviceData = {'error': 'Failed to get device info: $e'};
        _loadingDevice = false;
      });
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'brand': build.brand,
      'model': build.model,
      'device': build.device,
      'manufacturer': build.manufacturer,
      'androidVersion': build.version.release,
      'sdkInt': build.version.sdkInt,
      'isPhysicalDevice': build.isPhysicalDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'isPhysicalDevice': data.isPhysicalDevice,
      'identifierForVendor': data.identifierForVendor,
    };
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.montserrat()),
        backgroundColor: const Color.fromRGBO(255, 187, 214, 1),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade200, Colors.pink.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                GFAvatar(
                  radius: 56,
                  backgroundImage: const AssetImage('assets/profil.png'),
                  shape: GFAvatarShape.standard,
                ),
                const SizedBox(height: 12),
                Text(
                  _displayNameFromEmail(email),
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(email, style: GoogleFonts.montserrat(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                GFListTile(
                  avatar: const Icon(Icons.notifications_none, color: Colors.pinkAccent),
                  titleText: 'Notifications',
                  onTap: () {},
                ),
                GFListTile(
                  avatar: const Icon(Icons.chat_bubble_outline, color: Colors.pinkAccent),
                  titleText: 'Reviews',
                  onTap: () {},
                ),
                GFListTile(
                  avatar: const Icon(Icons.payment_outlined, color: Colors.pinkAccent),
                  titleText: 'Payments',
                  onTap: () {},
                ),
                GFListTile(
                  avatar: const Icon(Icons.settings_outlined, color: Colors.pinkAccent),
                  titleText: 'Settings',
                  onTap: () {},
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Device info', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                ),
                if (_loadingDevice)
                  const Center(child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ))
                else if (_deviceData.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('No device info available', style: GoogleFonts.montserrat()),
                  )
                else ..._deviceData.entries.map((e) => ListTile(
                      title: Text(e.key),
                      subtitle: Text('${e.value}'),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: GFButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              text: 'Logout',
              icon: const Icon(Icons.power_settings_new, color: Colors.white),
              color: Colors.pink.shade100,
              blockButton: true,
            ),
          ),
        ],
      ),
    );
  }

  String _displayNameFromEmail(String email) {
    if (email.isEmpty) return 'Guest';
    final local = email.split('@').first;
    if (local.isEmpty) return 'Guest';
    final parts = local.replaceAll(RegExp(r'[._]'), ' ').split(' ');
    final transformed = parts.map((p) => p.isEmpty ? p : '${p[0].toUpperCase()}${p.substring(1)}').join(' ');
    return transformed;
  }
}

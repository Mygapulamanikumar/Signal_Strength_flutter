import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_telephony_info/flutter_telephony_info.dart';
import 'package:permission_handler/permission_handler.dart';

class contentDisplayUI extends StatefulWidget {
  const contentDisplayUI({super.key});

  @override
  State<contentDisplayUI> createState() => _contentDisplayUIState();
}

class _contentDisplayUIState extends State<contentDisplayUI> {
  List<TelephonyInfo>? _telephonyInfo;
  final _flutterTelephonyInfoPlugin = TelephonyAPI();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        updateSignalStrength();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    if (await Permission.phone
        .request()
        .isGranted) {
      initPlatformState();
    } else {
    }
  }

  Future<void> initPlatformState() async {
    List<TelephonyInfo>? telephonyInfo;
    try {
      telephonyInfo = (await _flutterTelephonyInfoPlugin.getInfo())
          ?.cast<TelephonyInfo>();
    } on PlatformException {
      telephonyInfo = null;
    }

    if (!mounted) return;
    setState(() {
      _telephonyInfo = telephonyInfo;
    });
  }

  Future<void> updateSignalStrength() async {
    try {
      List<TelephonyInfo>? telephonyInfo =
      (await _flutterTelephonyInfoPlugin.getInfo())
          ?.cast<TelephonyInfo>();
      setState(() {
        _telephonyInfo = telephonyInfo;
      });
    } on Exception catch (e) {
      print("Error updating signal strength: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _telephonyInfo != null
          ? ListView.builder(
        itemCount: _telephonyInfo!.length,
        itemBuilder: (context, index) {
          TelephonyInfo? info = _telephonyInfo![index];

          if (info!.cellId != null &&
              info.cellId!.isNotEmpty &&
              info.cellSignalStrength != null &&
              info.cellSignalStrength!.isNotEmpty) {
            List<String> cellIdValues = [];
            info.cellId!.split(' ').forEach((part) {
              if (part
                  .trim()
                  .isNotEmpty) {
                List<String> keyValue = part.split('=');
                if (keyValue.length == 2) {
                  cellIdValues.add(keyValue[1]);
                }
              }
            });

            List<String> signalStrengthValues = [];
            info.cellSignalStrength!.split(' ').forEach((part) {
              if (part
                  .trim()
                  .isNotEmpty) {
                List<String> keyValue = part.split('=');
                if (keyValue.length == 2) {
                  signalStrengthValues.add(keyValue[1]);
                }
              }
            });
            if (cellIdValues.length > 9 &&
                signalStrengthValues.length > 7) {
              return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'SIM ${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(width: 10),
                            Text(
                              info.displayName ?? "Unknown",
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(info.networkGeneration ?? "Unknown", style: const TextStyle(color: Colors.white)),
                            const SizedBox(width: 10),
                            Text(info.radioType ?? "Unknown", style: const TextStyle(color: Colors.white)),
                            const SizedBox(width: 10),
                            Text(info.mobileNetworkCode ?? "Unknown", style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(width: 15),
                            const Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('mCI', style: TextStyle(color: Colors.white)),
                                  Text('mPci', style: TextStyle(color: Colors.white)),
                                  Text('mTac', style: TextStyle(color: Colors.white)),
                                  Text('mEarFcn', style: TextStyle(color: Colors.white)),
                                  Text('mAlpha-L', style: TextStyle(color: Colors.white)),
                                  Text('mAlpha-S', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(': ${cellIdValues[0]}', style: const TextStyle(color: Colors.white)),
                                  Text(': ${cellIdValues[1]}', style: const TextStyle(color: Colors.white)),
                                  Text(': ${cellIdValues[2]}', style: const TextStyle(color: Colors.white)),
                                  Text(': ${cellIdValues[3]}', style: const TextStyle(color: Colors.white)),
                                  Text(': ${cellIdValues[8]}', style: const TextStyle(color: Colors.white)),
                                  Text(': ${cellIdValues[9]}', style: const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 30),
                            const Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('RSSI', style: TextStyle(color: Colors.white)),
                                  Text('RSRP', style: TextStyle(color: Colors.white)),
                                  Text('RSRQ', style: TextStyle(color: Colors.white)),
                                  Text('RSSNR', style: TextStyle(color: Colors.white)),
                                  Text('Level', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(': ${signalStrengthValues[0]} dBm', style: const TextStyle(color: Colors.white)),
                                  Text(': ${signalStrengthValues[1]} dBm', style: const TextStyle(color: Colors.white)),
                                  Text(': ${signalStrengthValues[2]} dBm', style: const TextStyle(color: Colors.white)),
                                  Text(': ${signalStrengthValues[3]} dBm', style: const TextStyle(color: Colors.white)),
                                  Text(': ${signalStrengthValues[7]}', style: const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
            }
          }
          return ListTile(
            title: Text('SIM ${index + 1}'),
          );
        },
      )
          : const CircularProgressIndicator(),
    );
  }
}
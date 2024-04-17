import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_telephony_info/flutter_telephony_info.dart';
import 'package:permission_handler/permission_handler.dart';

class contentDisplayUI extends StatefulWidget {
  const contentDisplayUI({Key? key});

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
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
    if (await Permission.phone.request().isGranted) {
      initPlatformState();
    } else {
      // Handle the scenario where the permission is denied
      // You might want to display a message to the user or handle it differently
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
              if (part.trim().isNotEmpty) {
                List<String> keyValue = part.split('=');
                if (keyValue.length == 2) {
                  cellIdValues.add(keyValue[1]);
                }
              }
            });

            List<String> signalStrengthValues = [];
            info.cellSignalStrength!.split(' ').forEach((part) {
              if (part.trim().isNotEmpty) {
                List<String> keyValue = part.split('=');
                if (keyValue.length == 2) {
                  signalStrengthValues.add(keyValue[1]);
                }
              }
            });

            // Ensure the lists have enough elements before accessing
            if (cellIdValues.length > 9 &&
                signalStrengthValues.length > 7) {
              // Display parsed cellId data
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'SIM ${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            info.displayName ?? "Unknown",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text(info.networkGeneration ?? "Unknown"),
                          const SizedBox(width: 10),
                          Text(info.radioType ?? "Unknown"),
                          const SizedBox(width: 10),
                          Text(info.mobileNetworkCode ?? "Unknown"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('mCI: ${cellIdValues[0]}'),
                                Text('mPci: ${cellIdValues[1]}'),
                                Text('mTac: ${cellIdValues[2]}'),
                                Text('mEarFcn: ${cellIdValues[3]}'),
                                Text('mBandWidth: ${cellIdValues[5]}'),
                                Text('mAlpha-L: ${cellIdValues[8]}'),
                                Text('mAlpha-S: ${cellIdValues[9]}'),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('RSSI: ${signalStrengthValues[0]}'),
                                Text('RSRP: ${signalStrengthValues[1]}'),
                                Text('RSSNR: ${signalStrengthValues[3]}'),
                                Text('CQI Index: ${signalStrengthValues[4]}'),
                                Text('CQI: ${signalStrengthValues[5]}'),
                                Text('TA: ${signalStrengthValues[6]}'),
                                Text('Level: ${signalStrengthValues[7]}'),
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
          // Return a default widget if data is not available or lists don't have enough elements
          return ListTile(
            title: Text('SIM ${index + 1}'),
            subtitle: const Text('Cell ID data not available'),
          );
        },
      )
          : const CircularProgressIndicator(),
    );
  }
}
Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
const SizedBox(width: 15),
const Flexible(
flex: 1,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text('mCI'),
Text('mPci'),
Text('mTac'),
Text('mEarFcn'),
Text('mAlpha-L'),
Text('mAlpha-S'),
],
),
),
const SizedBox(width: 15),
Flexible(
flex: 1,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(': ${cellIdValues[0]}'),
Text(': ${cellIdValues[1]}'),
Text(': ${cellIdValues[2]}'),
Text(': ${cellIdValues[3]}'),
Text(': ${cellIdValues[8]}'),
Text(': ${cellIdValues[9]}'),
],
),
),
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:phoneinformations/phoneinformations.dart';

class phInfo extends StatefulWidget {
const phInfo({super.key});

@override
State<phInfo> createState() => _phoneInfoState();
}
class _phoneInfoState extends State<phInfo> {
String model = "";
String andoidVersion = "";
String serial = "";
String id = "";
String androidId = "";
String manufacturer = "";
String brand = "";
String sdkInt = "";
String simSerialNumber = "";
String simNumber = "";
String subscriberID = "";
String networkCountryISO = "";
String simCountryISO = "";
String softwareVersion = "";
String voiceMailNumber = "";
String networkType = "";
String networkGeneration = "";
String cid = "";
String lac = "";
String simOperator = "";
String mobileNetworkCode = "";
String mobileCountryCode = "";

@override
void initState() {
super.initState();
initPlatformState();
}

@override
void dispose() {
super.dispose();
}

Future<void> initPlatformState() async {
PhoneInfo? phoneInfos;
try {
phoneInfos = await Phoneinformations.getPhoneInformation();
model = phoneInfos.model;
andoidVersion = phoneInfos.andoidVersion;
serial = phoneInfos.serial;
id = phoneInfos.id;
androidId = phoneInfos.androidId;
manufacturer = phoneInfos.manufacturer;
sdkInt = phoneInfos.sdkInt;
simSerialNumber = phoneInfos.simSerialNumber;
simNumber = phoneInfos.simNumber;
subscriberID = phoneInfos.subscriberID;
networkCountryISO = phoneInfos.networkCountryISO;
simCountryISO = phoneInfos.simCountryISO;
mobileNetworkCode = phoneInfos.mobileNetworkCode;
mobileCountryCode = phoneInfos.mobileCountryCode;
softwareVersion = phoneInfos.softwareVersion;
voiceMailNumber = phoneInfos.voiceMailNumber;
networkType = phoneInfos.networkType;
networkGeneration = phoneInfos.networkGeneration;
cid = phoneInfos.cid;
lac = phoneInfos.lac;
simOperator = phoneInfos.simOperator;
} on PlatformException {
phoneInfos = null;
}
if (!mounted) return;
setState(() {});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Phone Info'),
),
body: ListTile(
subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
const SizedBox(width: 15),
const Flexible(
flex: 1,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text('Version'),
Text('Model'),
Text('sdkInt'),
Text('id'),
Text('VirtualId'),
Text('IMEI'),
Text('PhoneNO'),
Text('DeviceId'),
Text('CID'),
Text('NC-ISO'),
Text('simOperator'),
Text('NetworkCode'),
Text('CountryCode'),
Text('SIM-ISO'),
Text('Version'),
Text('Network'),
Text('Generation'),
Text('LAC'),
],
),
),
const SizedBox(width: 15),
Flexible(
flex: 1,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(': $andoidVersion'),
Text(': $model'),
Text(': $sdkInt'),
Text(': $id'),
Text(': $androidId'),
Text(': $simSerialNumber'),
Text(': $simNumber'),
Text(': $subscriberID'),
Text(': $cid'),
Text(': $networkCountryISO'),
Text(': $simOperator'),
Text(': $mobileNetworkCode'),
Text(': $mobileCountryCode'),
Text(': $simCountryISO'),
Text(': $softwareVersion'),
Text(': $networkType'),
Text(': $networkGeneration'),
Text(': $lac'),
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


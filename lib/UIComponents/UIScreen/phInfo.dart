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
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

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
        title:const Text('Phone Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData.dark().copyWith(
                  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
                  dividerColor: Colors.grey,
                ),
                child: DataTable(
                  dividerThickness: 1.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('Attribute'),
                    ),
                    DataColumn(
                      label: Text('Value'),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Version')),
                        DataCell(Text(': $andoidVersion')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Model')),
                        DataCell(Text(': $model')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('SDK Int')),
                        DataCell(Text(': $sdkInt')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('VirtualId')),
                        DataCell(Text(': $androidId')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('IMEI')),
                        DataCell(Text(': $simSerialNumber')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('PhoneNO')),
                        DataCell(Text(': $simNumber')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('DeviceId')),
                        DataCell(Text(': $subscriberID')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('CID')),
                        DataCell(Text(': $cid')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('NC-ISO')),
                        DataCell(Text(': $networkCountryISO')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('simOperator')),
                        DataCell(Text(': $simOperator')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('NetworkCode')),
                        DataCell(Text(': $mobileNetworkCode')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('CountryCode')),
                        DataCell(Text(': $mobileCountryCode')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('SIM-ISO')),
                        DataCell(Text(': $simCountryISO')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Version')),
                        DataCell(Text(': $softwareVersion')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Network')),
                        DataCell(Text(': $networkType')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('Generation')),
                        DataCell(Text(': $networkGeneration')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(Text('LAC')),
                        DataCell(Text(': $lac')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
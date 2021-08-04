import 'package:flutter/material.dart';

// import 'package:battery_plus/battery_plus.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Battery _battery = Battery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<AndroidBatteryInfo?>(
                  stream: BatteryInfoPlugin().androidBatteryInfoStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text("Voltage: ${(snapshot.data!.voltage)} mV"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Charging status: ${(snapshot.data!.chargingStatus.toString().split(".")[1])}"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Battery Level: ${(snapshot.data!.batteryLevel)} %"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Battery Capacity: ${(snapshot.data!.batteryCapacity! / 1000)} mAh"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Current Now: ${(snapshot.data!.currentNow)! / 1000} mAh "),
                          SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //     "Current Avg: ${(snapshot.data!.currentAverage)! / 1000} mAh "),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text("Temperature: ${snapshot.data!.temperature} "),
                          SizedBox(
                            height: 20,
                          ),
                          // Text("Scale: ${(snapshot.data!.scale)} "),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text(
                              "Remaining energy: ${-(snapshot.data!.remainingEnergy! * 1.0E-9)} Watt-hours,"),
                          SizedBox(
                            height: 20,
                          ),
                          _getChargeTime(snapshot.data),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChargeTime(AndroidBatteryInfo? data) {
    if (data!.chargingStatus == ChargingStatus.Charging) {
      return data.chargeTimeRemaining == -1
          ? Text("Calculating charge time remaining")
          : Text(
              "Charge time remaining: ${(data.chargeTimeRemaining! / 1000 / 60).truncate()} minutes");
    }
    return Text("Battery is full or not connected to a power source");
  }
}

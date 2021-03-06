import 'package:flutter/material.dart';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';

import '/widgets/battery_level_widget.dart';
import '/widgets/battery_health_widget.dart';
import '/widgets/battery_status_widget.dart';
import '/widgets/battery_temperature_widget.dart';
import '/widgets/battery_voltage_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final double _sw = MediaQuery.of(context).size.width;
    final double _sh = MediaQuery.of(context).size.height;
    bool isDarkMode =
        Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'BATTERY INFO',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Hero',
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          height: _sh,
          width: _sw,
          // color: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: StreamBuilder<AndroidBatteryInfo?>(
            stream: BatteryInfoPlugin().androidBatteryInfoStream,
            builder: (BuildContext context,
                AsyncSnapshot<AndroidBatteryInfo?> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BatteryLevelWidget(
                      batteryLevel: snapshot.data!.batteryLevel,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BatteryHealthWidget(
                          health: snapshot.data!.health,
                          capacity: ((snapshot.data!.batteryCapacity! / 1000) /
                                  (snapshot.data!.batteryLevel!) *
                                  100)
                              .toInt(),
                        ),
                        BatteryStatusWidget(
                          chargingStatus: snapshot.data!.chargingStatus
                              .toString()
                              .split(".")[1],
                          batteryLevel: snapshot.data!.batteryLevel,
                          powerSource: snapshot.data!.pluggedStatus == 'unknown'
                              ? 'Battery'
                              : 'USB port',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BatteryTemperatureWidget(
                          currentNow: ((snapshot.data!.currentNow)! / 1000),
                          temperature: snapshot.data!.temperature,
                        ),
                        BatteryVoltageWidget(voltage: snapshot.data!.voltage),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _getChargeTime(snapshot.data),
                    SizedBox(height: 16),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _getChargeTime(AndroidBatteryInfo? data) {
    if (data!.chargingStatus == ChargingStatus.Charging) {
      return data.chargeTimeRemaining == -1
          ? Container(child: const Text("Calculating charge time remaining"))
          : Container(
              child: Text(
                  "Charge time remaining: ${(data.chargeTimeRemaining! / 1000 / 60).truncate()} minutes"),
            );
    }
    return Container(
      child: const Text(
        "Battery is full or not connected to a power source",
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 16,
        ),
      ),
    );
  }
}

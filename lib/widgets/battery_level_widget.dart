import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BatteryLevelWidget extends StatelessWidget {
  BatteryLevelWidget({required this.batteryLevel});
  final batteryLevel;

  Widget build(BuildContext context) {
    Color barColor = Colors.green;
    if (batteryLevel! >= 50) {
      barColor = Colors.green;
    } else if (batteryLevel >= 20 && batteryLevel < 40) {
      barColor = Colors.orange;
    } else if (batteryLevel < 20) {
      barColor = Colors.red;
    }

    return Container(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Current battery level',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SfLinearGauge(
              minimum: 0,
              maximum: 100,
              orientation: LinearGaugeOrientation.horizontal,
              barPointers: [
                LinearBarPointer(
                  thickness: 16,
                  value: batteryLevel.toDouble(),
                  color: barColor,
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${batteryLevel.toString()}%',
            style: const TextStyle(
              fontSize: 64,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}

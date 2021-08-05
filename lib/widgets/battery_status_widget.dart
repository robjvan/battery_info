import 'package:flutter/material.dart';

class BatteryStatusWidget extends StatelessWidget {
  BatteryStatusWidget({
    required this.chargingStatus,
    required this.batteryLevel,
    required this.powerSource,
  });
  final String chargingStatus;
  final String powerSource;
  final int? batteryLevel;

  @override
  Widget build(BuildContext context) {
    final double _sw = MediaQuery.of(context).size.width;

    // half-width container
    return Container(
      width: (_sw / 2) - 24,
      height: 200,
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Charging Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            chargingStatus,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: powerSource == "Battery" ? Colors.red : Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Power source',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(powerSource),
          const SizedBox(height: 8),
          Icon(
            powerSource == "Battery"
                ? batteryLevel! > 15
                    ? Icons.battery_full_rounded
                    : Icons.battery_alert_rounded
                : Icons.usb_rounded,
            size: 64,
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
          )
        ],
      ),
    );
  }
}

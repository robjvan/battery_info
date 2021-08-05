import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BatteryVoltageWidget extends StatelessWidget {
  BatteryVoltageWidget({required this.voltage});
  final int? voltage;
  @override
  Widget build(BuildContext context) {
    final double _sw = MediaQuery.of(context).size.width;

    // half-width container
    bool _isDarkMode =
        Theme.of(context).textTheme.bodyText1!.color == Colors.white;
    return Container(
      width: (_sw / 2) - 24,
      height: (_sw / 2) - 24,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SfRadialGauge(
          title: GaugeTitle(
            text: 'Current voltage',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          axes: <RadialAxis>[
            RadialAxis(
                canScaleToFit: true,
                pointers: [
                  NeedlePointer(
                    needleEndWidth: 5,
                    needleLength: 0.75,
                    value: (voltage!.toDouble()) / 1000,
                    needleColor: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.6),
                  ),
                ],
                minimum: 3.0,
                maximum: 4.5,
                ranges: [
                  GaugeRange(
                    startValue: 3.0,
                    endValue: 3.6,
                    color: _isDarkMode
                        ? Colors.orange.withOpacity(0.6)
                        : Colors.orange,
                  ),
                  GaugeRange(
                    startValue: 3.6,
                    endValue: 4.2,
                    color: _isDarkMode
                        ? Colors.green.withOpacity(0.6)
                        : Colors.green,
                  ),
                  GaugeRange(
                    startValue: 4.2,
                    endValue: 4.5,
                    color: _isDarkMode
                        ? Colors.orange.withOpacity(0.6)
                        : Colors.orange,
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Container(
                      child: Text('${voltage! / 1000} V'),
                    ),
                    angle: 90,
                    positionFactor: 0.8,
                  )
                ])
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BatteryTemperatureWidget extends StatelessWidget {
  BatteryTemperatureWidget({
    required this.currentNow,
    required this.temperature,
  });
  final double currentNow;
  final int? temperature;

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
            text: 'Temperature',
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
                    value: temperature!.toDouble(),
                    needleColor: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.6),
                  ),
                ],
                maximum: 70,
                minimum: 10,
                ranges: [
                  GaugeRange(
                    startValue: 10,
                    endValue: 35,
                    color: _isDarkMode
                        ? Colors.green.withOpacity(0.6)
                        : Colors.green,
                  ),
                  GaugeRange(
                    startValue: 35,
                    endValue: 55,
                    color: _isDarkMode
                        ? Colors.orange.withOpacity(0.6)
                        : Colors.orange,
                  ),
                  GaugeRange(
                    startValue: 55,
                    endValue: 70,
                    color:
                        _isDarkMode ? Colors.red.withOpacity(0.6) : Colors.red,
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Container(
                      child: Text('$temperature °C'),
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

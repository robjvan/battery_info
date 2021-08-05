import 'package:flutter/material.dart';

class BatteryHealthWidget extends StatelessWidget {
  BatteryHealthWidget({
    required this.health,
    required this.capacity,
  });
  final String? health;
  final int? capacity;

  @override
  Widget build(BuildContext context) {
    final double _sw = MediaQuery.of(context).size.width;

    String _healthString = '';
    Color _healthColor = Colors.green;

    switch (health) {
      case 'heath_good':
        _healthString = 'Good';
        _healthColor = Colors.green;
        break;
      case 'heath_bad':
        _healthString = 'Bad';
        _healthColor = Colors.red;
        break;
    }

    return Container(
      width: (_sw / 2) - 24,
      height: 200,
      // height: (_sw / 2) - 24,
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Estimated capacity',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                child: Icon(
                  Icons.info_outline,
                  size: 18,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          'Disclaimer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                        content: const Text(
                          'This is an estimate and may not be accurate.  Do not use this app as proof for service requests.',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$capacity ',
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Montserrat',
                ),
              ),
              const Text(
                'mAh',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ],
          ),
          Spacer(),
          const Text(
            'Overall health',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$_healthString',
            style: TextStyle(
              fontSize: 32,
              color: _healthColor,
              fontFamily: 'Montserrat',
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

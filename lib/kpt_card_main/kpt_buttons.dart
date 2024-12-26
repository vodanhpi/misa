import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/kpt_data.dart';

class KptButtons extends StatelessWidget {
  final VoidCallback onFeedback;

  const KptButtons({super.key, required this.onFeedback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 4,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Card(
              color: myColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4.0,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset('assets/images/Icon Сolor.svg'),
                    const SizedBox(height: 4),
                    const Text('Xem chi tiết', style: TextStyle(fontSize: 14, color: black))
                  ]
                )
              )
            )
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Card(
              color: myColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: onFeedback,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.feedback_outlined),
                    SizedBox(height: 4),
                    Text(
                      'Phản hồi',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }
}

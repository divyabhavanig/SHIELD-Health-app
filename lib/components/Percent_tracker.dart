import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentTracker extends StatefulWidget {
  final Color Pcolor;
  final double Pmax;
  final double Pvalue;
  final String Ptext;
  const PercentTracker(
      {super.key,
      required this.Pcolor,
      required this.Pmax,
      required this.Pvalue,
      required this.Ptext});

  @override
  State<PercentTracker> createState() => _PercentTrackerState();
}

class _PercentTrackerState extends State<PercentTracker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: 120,
        child: Container(
          child: Center(
            child: CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 10,
              progressColor: widget.Pcolor,
              backgroundColor: Color(0xff1aa48c),
              circularStrokeCap: CircularStrokeCap.round,
              percent: (widget.Pvalue / widget.Pmax),
              center: Center(
                child: Text(
                  widget.Ptext,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));
  }
}

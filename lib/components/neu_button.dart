import 'package:flutter/material.dart';

class NeuButton extends StatelessWidget {
  final Widget text;
  const NeuButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: text,
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xff003c3a),
        shape: BoxShape.circle,
        boxShadow: [
          //darker shadow at bottom right
          BoxShadow(
            color: Color(0xff002a29),
            offset: Offset(10, 10),
            blurRadius: 20,
            spreadRadius: 1,
          ),

          //lighter shadow at top left
          BoxShadow(
            color: Color(0xff015b49),
            offset: Offset(-10, -10),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Color(0xff4891A4),
        //     Color(0xff123F52),
        //   ],
        // )
      ),
    );
  }
}

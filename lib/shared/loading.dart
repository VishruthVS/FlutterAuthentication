import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[300],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white54,
          size: 50.0,
        ),
      ),
    );
  }
}

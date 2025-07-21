import 'package:flutter/material.dart';

class UnexpectedErrorScreen extends StatelessWidget {
  const UnexpectedErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, size: 48, color: Colors.red),
              SizedBox(height: 12),
              Text(
                "Something went wrong!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              SizedBox(height: 12),
              Text("Please restart the app or contact support."),
            ],
          ),
        ),
      ),
    );
  }
}

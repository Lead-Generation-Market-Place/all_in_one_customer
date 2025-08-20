import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Yelpax'),

      actions: [
        InkWell(child: Icon(Icons.settings_outlined)),
        SizedBox(width: 10),
        InkWell(child: Icon(Icons.notifications_outlined)),

        SizedBox(width: 10),
        InkWell(child: Icon(Icons.question_mark_outlined)),
        SizedBox(width: 10),
        InkWell(child: Icon(CupertinoIcons.heart)),
      ],
    );
  }
}

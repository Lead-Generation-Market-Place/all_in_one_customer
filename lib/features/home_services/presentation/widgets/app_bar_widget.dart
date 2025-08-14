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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Theme.of(context).primaryColor,
      title: Text('Yelpax'),
      elevation: 2.2,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
      actions: [
        InkWell(child: Icon(Icons.settings_outlined)),
        SizedBox(width: 10),
        InkWell(child: Icon(Icons.notifications_outlined)),
        SizedBox(width: 10),
        InkWell(child: Icon(CupertinoIcons.cart)),
        SizedBox(width: 10),
        InkWell(child: Icon(Icons.question_mark_outlined)),
        SizedBox(width: 10),
        InkWell(child: Icon(CupertinoIcons.heart)),
      ],
    );
  }
}

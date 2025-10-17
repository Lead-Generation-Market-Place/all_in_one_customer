import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/core/constants/app_constants.dart';

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
      backgroundColor: Theme.of(context).primaryColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: Theme.of(context).primaryColor,
      elevation: 2.2,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
      actions: [
        InkWell(
          child: Icon(Icons.settings_outlined),
          onTap: () => AppConstants.navigateKeyword.currentState?.pushNamed(
            AppRouter.settingsScreen,
          ),
        ),
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

import 'package:flutter/material.dart';

Widget buildNoticeBanner(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(right: 8, top: 0, left: 8),
    padding: const EdgeInsets.only(right: 8, top: 16, left: 8, bottom: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,

      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall,
      'Execulusive: Up to 30% off local in-app invite-only. start saving now code ',
    ),
  );
}

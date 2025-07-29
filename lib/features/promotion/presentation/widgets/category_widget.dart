import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';

Widget buildCategory(
  BuildContext context,
  List categories,
  VoidCallback onPress,
  int index,
) {
  return Card(
    child: Column(
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            height: height(context) / 15,
            width: width(context) / 3,
            decoration: BoxDecoration(
              //color: Colors.amber,
              image: DecorationImage(
                image: AssetImage('assets/images/y_logo.png'),
              ),
            ),
          ),
        ),
        Text(categories[index]),
      ],
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/height.dart';
import 'custom_input.dart';

Widget buildSliverAppbar(BuildContext context) {
  return SliverAppBar(
    expandedHeight: height(context) / 6,
    floating: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [Text('Yelpax')]),
                Row(
                  children: [
                    InkWell(child: Icon(CupertinoIcons.heart)),
                    InkWell(child: Icon(CupertinoIcons.question)),
                    InkWell(child: Icon(CupertinoIcons.cart)),
                    InkWell(child: Icon(Icons.notifications_outlined)),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
              child: CustomInputField(
                label: 'Search...',
                hintText: '',
                inputType: TextInputType.text,
                suffixIcon: Icons.search_outlined,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

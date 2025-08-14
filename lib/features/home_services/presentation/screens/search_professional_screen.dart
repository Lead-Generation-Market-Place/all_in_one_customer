import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';

Widget buildSearchFieldData(Professional pro) {
  return Center(
    child: ListTile(
      leading: CircleAvatar(child: Text(pro.id)),
      title: Text(pro.name),
      subtitle: Text(pro.serviceType),
    ),
  );
}

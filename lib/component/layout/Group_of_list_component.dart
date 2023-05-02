
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ListItem_store_component.dart';

class GroupOfListComponent extends StatelessWidget {
  GroupOfListComponent({required this.category});
  String category;

  @override
  Widget build(BuildContext context) {

    return   Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 2),
                blurRadius: 7,
              )
            ]
        ),
        child: Column(
          children: [
            // ListItemComponent(category: category),
            // ListItemComponent(category: category),
            // ListItemComponent(category: category),
            // ListItemComponent(category: category),
          ],
        )
    );
  }
}
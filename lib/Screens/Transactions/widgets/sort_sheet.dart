 import 'package:flutter/material.dart';
import 'package:money_manager/Screens/Transactions/widgets/sort_widget.dart';

// ignore: non_constant_identifier_names
Future<void> ShowSortSheet(BuildContext ctx, dynamic sortIndex) async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: ctx,
        builder: (ctx) {
          return  Container(
            height: 200,
            child: Column(
              children: [SortWidget(indexCount: sortIndex,)],
            ),
          );
        });
  }
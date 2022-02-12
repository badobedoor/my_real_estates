import 'package:flutter/material.dart';

class DropListModel {
  DropListModel(this.listOptionItems);

  final List<OptionItem> listOptionItems;
}

class OptionItem {
  String? id;
  String? title;

  OptionItem({@required this.id, @required this.title});
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
// create a unique id using uuid

final uuid = Uuid().v4();

// date formatter
final formatedDate = DateFormat.yMd();

//enum for categories
// enum Category { lowest, low, high, highst }

//category icons
final CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.travel_explore,
  Category.leasure: Icons.leave_bags_at_home_rounded,
  Category.work: Icons.work,
};

// enum for category
enum Category { food, travel, leasure, work }

class ExpenceModel {
// create constructor
  ExpenceModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getFrmated date
  String get formattdeDateValue {
    return formatedDate.format(date);
  }
}

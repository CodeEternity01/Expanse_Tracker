// we use uuid to build a new id uniquilly dynamically
// we not category a string type because it is very flexible and can accept any wrong value
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { food, travel, leisure, work, dance, study }

const uuid = Uuid();
final formatter = DateFormat.yMd();
const CategoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.dance: Icons.girl,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff,
  Category.study: Icons.book,
};

class Expence {
  Expence({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenceBucket {
  const ExpenceBucket({required this.category, required this.expences});

  ExpenceBucket.forCategory(List<Expence> allExpences, this.category)
  :expences=allExpences.where((expence) => expence.category==category).toList() ;

  final Category category;
  final List<Expence> expences;

  double get totalExpences {
    double sum = 0;
    // for (var i = 0; i < expences.length;i++)
    for (final expence in expences) {
      sum += expence.amount;
    }
    return sum;
  }
}

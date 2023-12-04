import 'package:expence_master/models/expence.dart';
import 'package:expence_master/widgets/add_new_expence.dart';
import 'package:expence_master/widgets/expence_list.dart';
import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  // expenceList
  final List<ExpenceModel> _expenceList = [
    ExpenceModel(
        title: "Football",
        amount: 12.5,
        date: DateTime.now(),
        category: Category.leasure),
    ExpenceModel(
        title: "Apple",
        amount: 10,
        date: DateTime.now(),
        category: Category.food),
    ExpenceModel(
        title: "Programming",
        amount: 100,
        date: DateTime.now(),
        category: Category.work),
  ];

  // add new expence
  void onAddNewExpence(ExpenceModel expence) {
    setState(() {
      _expenceList.add(expence);
    });
  }

  // function to open a modal overlay
  void _openAddExpencesOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewExpence(
          onAddExpence: onAddNewExpence,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 61, 105),
        title: const Text(
          "Expence Master",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            color: Color.fromARGB(255, 243, 198, 0),
            child: IconButton(
              onPressed: _openAddExpencesOverlay,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ExpenceList(expenceList: _expenceList),
        ],
      ),
    );
  }
}

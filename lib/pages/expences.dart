import 'package:expence_master/models/expence.dart';
import 'package:expence_master/widgets/add_new_expence.dart';
import 'package:expence_master/widgets/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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

  // PIE Chart
  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };

  // add new expence
  void onAddNewExpence(ExpenceModel expence) {
    setState(() {
      _expenceList.add(expence);
      calCategoryValues();
    });
  }

  // remove expences
  void onDeleteExpence(ExpenceModel expence) {
    // store the deleted expence
    ExpenceModel deletedExpence = expence;
    // get the index of the removing expence
    final int removedIndex = _expenceList.indexOf(expence);
    setState(() {
      _expenceList.remove(expence);
      calCategoryValues();
    });
    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Delete successfully'),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                _expenceList.insert(removedIndex, deletedExpence);
                calCategoryValues();
              });
            }),
      ),
    );
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

  double foodVal = 0;
  double leasureVal = 0;
  double travelVal = 0;
  double workVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double leasureValTotal = 0;
    double travelValTotal = 0;
    double workValTotal = 0;

    for (final expence in _expenceList) {
      if (expence.category == Category.food) {
        foodValTotal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelValTotal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        leasureValTotal += expence.amount;
      }
      if (expence.category == Category.work) {
        workValTotal += expence.amount;
      }
    }
    setState(() {
      foodVal = foodValTotal;
      leasureVal = leasureValTotal;
      travelVal = travelValTotal;
      workVal = workValTotal;
    });

    // update the datamap
    dataMap = {
      "Food": foodVal,
      "Travel": travelVal,
      "Leasure": leasureVal,
      "Work": workVal,
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    calCategoryValues();
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
          PieChart(dataMap: dataMap),
          ExpenceList(
            expenceList: _expenceList,
            onDeleteExpence: onDeleteExpence,
          ),
        ],
      ),
    );
  }
}

import 'package:expence_master/models/expence.dart';
import 'package:flutter/material.dart';

class AddNewExpence extends StatefulWidget {
  final void Function(ExpenceModel expence) onAddExpence;
  const AddNewExpence({super.key, required this.onAddExpence});

  @override
  State<AddNewExpence> createState() => _AddNewExpenceState();
}

class _AddNewExpenceState extends State<AddNewExpence> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

// date variables
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  DateTime _selectedDate = DateTime.now();

  // date picker
  Future<void> _openDateModal() async {
    try {
      // show the date model then store the user selected date
      final pickedDate = await showDatePicker(
          context: context, firstDate: firstDate, lastDate: lastDate);
      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // handle form submit
  void _handleFormSubmit() {
    // form validation
    // convert the amount in to a double
    final userAmount = double.parse(_amountController.text.trim());
    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter valid data'),
            content: const Text(
                "Please enter valid data for the title and the amount fields. The title can not be empty and the amount can not be less than zero"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              )
            ],
          );
        },
      );
    } else {
      // save the data
      // create the new expence
      ExpenceModel newExpence = ExpenceModel(
          amount: userAmount,
          title: _titleController.text.trim(),
          date: _selectedDate,
          category: _selectedCategory);
      widget.onAddExpence(newExpence);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Title text feild
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "Add new expence title",
              label: Text("Title"),
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              // amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    hintText: "Enter the amount of your expence",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              // datepicker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formatedDate.format(_selectedDate)),
                    IconButton(
                        onPressed: _openDateModal,
                        icon: const Icon(Icons.date_range_outlined))
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(
                    () {
                      _selectedCategory = value!;
                    },
                  );
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // close the model button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      // save the data and close the modal button
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: _handleFormSubmit,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:expance_tracker/widget/chart/chart.dart';
import 'package:expance_tracker/widget/expences_item/expences_list.dart';
import 'package:expance_tracker/model/expence.dart';
import 'package:expance_tracker/widget/new_expence.dart';
import 'package:flutter/material.dart';

// we use scaffold as it set design,and background color
class Expences extends StatefulWidget {
  const Expences({super.key});
  @override
  State<Expences> createState() {
    return _ExpencesState();
  }
}

class _ExpencesState extends State<Expences> {
  final List<Expence> _reqisteredExpences = [
    Expence(
        title: 'Flutter Course',
        amount: 499,
        date: DateTime.now(),
        category: Category.study),
    Expence(
        title: 'Cinema',
        amount: 145,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openAddexpenceOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cnt) => NewExpence(onAddexpence: _addExpence),
    );
  }

  void _addExpence(Expence expence) {
    setState(() {
      _reqisteredExpences.add(expence);
    });
  }

  void _removeExpence(Expence expence) {
    final expenceIndex = _reqisteredExpences.indexOf(expence);
    setState(() {
      _reqisteredExpences.remove(expence);
    });
    // by below line only last one have undo option on simultaneoully removind more than one
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expence Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _reqisteredExpences.insert(expenceIndex, expence);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expence found. Start adding some!'),
    );
    if (_reqisteredExpences.isNotEmpty) {
      mainContent = ExpencesList(
          expences: _reqisteredExpences, onRemoveExpence: _removeExpence);
    }
    return Scaffold(
      // Tool bar with +(add) button=>row()
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Flutter Expence Tracker'
              //  it is use of ggole font
              // style: GoogleFonts.aguafinaScript().copyWith(fontSize: 16)

              ),
          // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          actions: [
            IconButton(
              onPressed: _openAddexpenceOverlay,
              icon: const Icon(Icons.add),
            )
          ]),
      body: width<600? Column(
        children: [
          Chart(expenses: _reqisteredExpences),
          Expanded(
            child: mainContent,
          ),
        ],
      ):
      Row(
          children: [
            // we use expanded because unconstraint widget inside an unconstraint widget cause problems
            // expanded limit the diamention and provide as much as device height and max width req. by child
            
          Expanded(child: Chart(expenses: _reqisteredExpences)),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}

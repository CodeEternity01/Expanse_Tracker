import 'package:expance_tracker/model/expence.dart';
import 'package:flutter/material.dart';
import 'package:expance_tracker/widget/expences_item/expences_item.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList(
      {super.key, required this.expences, required this.onRemoveExpence});

  final List<Expence> expences;
  final void Function(Expence expence) onRemoveExpence;
  @override
  Widget build(BuildContext context) {
    // listview is a scrolable column
    // here builder is good practice but listview can also directly accept list.
    return ListView.builder(
      itemCount: expences.length,
      // here dismissible is used to delete rows by swapping
      itemBuilder: (ctx, index) => Dismissible(
         background: Container(color: Theme.of(context).colorScheme.error.withBlue(20),
         margin: Theme.of(context).cardTheme.margin,
         ),
         
          key: ValueKey(expences[index]),
          onDismissed: (direction) {
            
            onRemoveExpence(expences[index]);
          },
          child: ExpencesItem(expences[index])),
    );
  }
}

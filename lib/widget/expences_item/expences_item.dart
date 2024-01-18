import 'package:expance_tracker/model/expence.dart';
import 'package:flutter/material.dart';

class ExpencesItem extends StatelessWidget {
  const ExpencesItem(this.expence,{super.key});

  final Expence expence;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: 
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
                Text(expence.title,style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 4),
                
                Row(
                  children: [
                    Text('\$${expence.amount.toStringAsFixed(2)}'),
                    const Spacer(),
                    Row(
                      children: [
                         Icon(CategoryIcon[expence.category]),
                       const SizedBox(width: 8,),
                        Text(expence.formattedDate)
                      ],
                    )
                  ],
                )
        ]),
      ),
    );
  }
}

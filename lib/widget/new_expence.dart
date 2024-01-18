import 'package:flutter/material.dart';
import 'package:expance_tracker/model/expence.dart';

class NewExpence extends StatefulWidget {
  const NewExpence({super.key, required this.onAddexpence});
  final void Function(Expence expence) onAddexpence;
  @override
  State<NewExpence> createState() {
    return _NewExpenceState();
  }
}

class _NewExpenceState extends State<NewExpence> {
  // this is for storing the val by user
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.dance;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 10, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenceData() {
    // tryparse('Hello')=>null,tryparse('3.14')=>3.14
    final enteredAmount = double.tryParse(_amountController.text);
    final amountisInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountisInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Plese make sure a valid title,amount,date and category was entered!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay')),
          ],
        ),
      );
      return;
    }
    widget.onAddexpence(
      Expence(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: ((context, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardspace + 16),
            child: Column(
              children: [
                if(width>600)
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Expanded(
                    child: TextField(
                    // onChanged: _saveTitleInput,
                    controller: _titleController,
                    maxLength: 50,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('title'),
                    ),
                                    ),
                  ),
               const SizedBox(width: 24,),
               Expanded(
                      child: TextField(
                        // onChanged: _saveTitleInput,
                        controller: _amountController,
                        maxLength: 50,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '& ',
                          label: Text('amount'),
                        ),
                      ),
                    ),

                 ],)
                 else
                  TextField(
                  // onChanged: _saveTitleInput,
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text('title'),
                  ),
                ),
                if(width>600)
                 Row(children: [
                     DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (Category) => DropdownMenuItem(
                                value: Category,
                                child: Text(Category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                      const SizedBox(width: 24 ,),
                      Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectedDate == null
                              ? 'No date Selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ),

                 ],)
                else
                 Row(
                  children: [
                    Expanded(
                      child: TextField(
                        // onChanged: _saveTitleInput,
                        controller: _amountController,
                        maxLength: 50,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '& ',
                          label: Text('amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectedDate == null
                              ? 'No date Selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if(width>600)
                   Row(children: [ 
                       const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: _submitExpenceData,
                        child: const Text('save expence')),
                    const SizedBox(
                      width: 10,
                    ),
                   ],)
                else
                 Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (Category) => DropdownMenuItem(
                                value: Category,
                                child: Text(Category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: _submitExpenceData,
                        child: const Text('save expence')),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

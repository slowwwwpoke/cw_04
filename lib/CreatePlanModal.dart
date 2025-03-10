import 'package:flutter/material.dart';
import 'Plan.dart';

class CreatePlanModal extends StatefulWidget {
  final Function(String, String, DateTime, String) addPlan;
  final Plan? plan;

  CreatePlanModal({required this.addPlan, this.plan});

  @override
  _CreatePlanModalState createState() => _CreatePlanModalState();
}

class _CreatePlanModalState extends State<CreatePlanModal> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedPriority = 'Medium';

  @override
  void initState() {
    super.initState();
    if (widget.plan != null) {
      _nameController.text = widget.plan!.name;
      _descriptionController.text = widget.plan!.description;
      _selectedDate = widget.plan!.date;
      _selectedPriority = widget.plan!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _nameController, decoration: InputDecoration(labelText: "Plan Name")),
          TextField(controller: _descriptionController, decoration: InputDecoration(labelText: "Description")),
          ElevatedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2022),
                lastDate: DateTime(2030),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
            child: Text("Select Date: ${_selectedDate.toLocal()}".split(' ')[0]),
          ),
          DropdownButton<String>(
            value: _selectedPriority,
            onChanged: (value) => setState(() => _selectedPriority = value!),
            items: ['Low', 'Medium', 'High'].map((String priority) {
              return DropdownMenuItem(value: priority, child: Text(priority));
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              widget.addPlan(_nameController.text, _descriptionController.text, _selectedDate, _selectedPriority);
              Navigator.pop(context);
            },
            child: Text("Save Plan"),
          ),
        ],
      ),
    );
  }
}

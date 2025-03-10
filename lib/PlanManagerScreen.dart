import 'package:flutter/material.dart';
import 'Plan.dart';
import 'CreatePlanModal.dart';

class PlanManagerScreen extends StatefulWidget {
  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = [];

  void addPlan(String name, String description, DateTime date) {
    setState(() {
      plans.add(Plan(name: name, description: description, date: date));
    });
  }

  void updatePlan(int index, String newName, String newDescription, DateTime newDate) {
    setState(() {
      plans[index] = Plan(name: newName, description: newDescription, date: newDate);
    });
  }

  void togglePlanCompletion(int index) {
    setState(() {
      plans[index].isCompleted = !plans[index].isCompleted;
    });
  }

  void deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adoption & Travel Plans")),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return GestureDetector(
            onDoubleTap: () => deletePlan(index),
            child: Dismissible(
              key: Key(plan.name),
              onDismissed: (_) => togglePlanCompletion(index),
              background: Container(color: Colors.green),
              child: Card(
                color: plan.isCompleted ? Colors.green[200] : Colors.white,
                child: ListTile(
                  title: Text(plan.name),
                  trailing: Icon(plan.isCompleted ? Icons.check : Icons.pending),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreatePlanModal(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openCreatePlanModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CreatePlanModal(addPlan: addPlan),
    );
  }
}

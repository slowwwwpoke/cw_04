import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'plan.dart';

class PlanManagerScreen extends StatefulWidget {
  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = [];

  void addPlan(String name, String description, DateTime date, String priority) {
    setState(() {
      plans.add(Plan(name: name, description: description, date: date, priority: priority));
    });
  }

  void updatePlan(int index, String name, String description, DateTime date, String priority) {
    setState(() {
      plans[index] = Plan(name: name, description: description, date: date, priority: priority);
    });
  }

  void markAsCompleted(int index) {
    setState(() {
      plans[index].isCompleted = !plans[index].isCompleted;
    });
  }

  void deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  /// Get color based on status (Pending/Completed) & Priority (High/Medium/Low)
  Color getPlanColor(Plan plan) {
    if (plan.isCompleted) {
      switch (plan.priority) {
        case "High":
          return Colors.red[200]!; // Faded Red for Completed High Priority
        case "Medium":
          return Colors.orange[200]!; // Faded Orange for Completed Medium Priority
        case "Low":
          return Colors.green[200]!; // Faded Green for Completed Low Priority
        default:
          return Colors.grey[400]!;
      }
    } else {
      switch (plan.priority) {
        case "High":
          return Colors.red[400]!; // Dark Red for Pending High Priority
        case "Medium":
          return Colors.orange[400]!; // Dark Orange for Pending Medium Priority
        case "Low":
          return Colors.green[400]!; // Dark Green for Pending Low Priority
        default:
          return Colors.blue[300]!;
      }
    }
  }

  void showCreatePlanModal() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String selectedPriority = "Medium";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create New Plan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Plan Name")),
              TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
              DropdownButton<String>(
                value: selectedPriority,
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value!;
                  });
                },
                items: ["Low", "Medium", "High"].map((priority) {
                  return DropdownMenuItem(value: priority, child: Text(priority));
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  addPlan(nameController.text, descriptionController.text, selectedDate, selectedPriority);
                  Navigator.pop(context);
                },
                child: Text("Add Plan"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adoption & Travel Plans")),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreatePlanModal,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];

          return Slidable(
            key: ValueKey(plan.name),
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => markAsCompleted(index),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.check,
                  label: 'Complete',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => deletePlan(index),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: getPlanColor(plan), // Color based on status & priority
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  plan.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: plan.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(plan.description),
                trailing: Text(
                  plan.priority,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

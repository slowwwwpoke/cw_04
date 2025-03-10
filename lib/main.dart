import 'package:flutter/material.dart';
import 'PlanManagerScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adoption & Travel Plans',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlanManagerScreen(),
    );
  }
}

import 'package:flutter/material.dart';

class DoctorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors List')),
      body: Center(child: Text('List of doctors here')),
    );
  }
}
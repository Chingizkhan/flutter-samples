import 'package:flutter/material.dart';
import 'package:test_crossplatform/sql/db/database.dart';
import 'model/Student.dart';

class SQFLiteScreen extends StatefulWidget {
  const SQFLiteScreen({Key? key}) : super(key: key);

  @override
  State<SQFLiteScreen> createState() => _SQFLiteScreenState();
}

class _SQFLiteScreenState extends State<SQFLiteScreen> {
  // late Future<List<Student>> _studentsList;

  // @override
  // void initState() {
  //   super.initState();
  //   updateStudentList();
  // }
  //
  // updateStudentList() {
  //   setState(() {
  //     _studentsList = DBProvider.db.getStudents();
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL Lite'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Salam'),
      ),
    );
  }
}

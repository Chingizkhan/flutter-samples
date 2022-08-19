import 'package:flutter/material.dart';

class StaticList extends StatelessWidget {
  const StaticList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List View',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Building List View'),
          centerTitle: true,
        ),
        body: const BodyListView(),
      ),
    );
  }
}

class BodyListView extends StatelessWidget {
  const BodyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  return ListView(
    padding: const EdgeInsets.all(8),
    // bad for performance
    // shrinkWrap: true,
    // scrollDirection: Axis.horizontal,
    // reverse: true,
    // itemExtent: 300,
    children: const [
      ListTile(
        title: Text('Sun'),
        leading: Icon(Icons.wb_sunny),
        subtitle: Text('Today Clear'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Cloudy'),
        leading: Icon(Icons.wb_cloudy),
        subtitle: Text('Today Clear'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Snow'),
        leading: Icon(Icons.ac_unit),
        subtitle: Text('Today Clear'),
        trailing: Icon(Icons.keyboard_arrow_right),
      )
    ],
  );
}

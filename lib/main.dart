import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_crossplatform/pages/scopedModel.dart';
import 'package:test_crossplatform/pages/user_info_page.dart';
import 'package:test_crossplatform/sql/SQFLiteScreen.dart';
import 'package:test_crossplatform/sql/db/database.dart';
import 'package:test_crossplatform/sql/model/Student.dart';
import 'pages/IO/IOFile.dart';
import 'pages/StaticList.dart';
import 'pages/dynamicList.dart';
import 'pages/form.dart';
import 'pages/http.dart';
import 'pages/navigation.dart';
import 'pages/navigationReturnData.dart';
import 'pages/provider/ProviderScreen.dart';
import 'pages/provider/homework.dart';
import 'pages/shared_preferences/shared_preferences_screen.dart';
import 'pages/weatherApp.dart';
import 'pages/weatherApp2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final studentsDb = StudentsDB('students');
  await studentsDb.db;

  final student = Student(1, 'Chingizkhan');
  studentsDb.insertStudent(student);

  print(await studentsDb.getStudents());

  runApp(
    const MaterialApp(
      home: SQFLiteScreen(),
    )
  );
}




// FONTS AND IMAGES

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'IndieFlower'
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Adding Assets'),
//         ),
//         body: Center(
//           child: Stack(
//             fit: StackFit.expand,
//             children: const [
//               Image(
//                 image: AssetImage('assets/images/car.jpg')
//               ),
//               Positioned(
//                 top: 16,
//                 left: 100,
//                 child: Text(
//                   'My custom font',
//                   style: TextStyle(
//                     fontSize: 30,
//                   )
//                 )
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }


// STATEFUL AND STATELESS WIDGETS

// class MyFirstApp extends StatefulWidget {
//   const MyFirstApp({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MyFirstAppState();
//   }
//
// }
//
// class _MyFirstAppState extends State<MyFirstApp> {
//   late bool _loading;
//   late double _progressValue;
//
//   @override
//   void initState() {
//     _loading = false;
//     _progressValue = 0.0;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.indigo,
//         appBar: AppBar(
//           title: const Text('My First App'),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             child: _loading
//               ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   LinearProgressIndicator(value: _progressValue,),
//                   Text(
//                     '${(_progressValue * 100).round()}%',
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20
//                     ),
//                   ),
//                 ],
//               )
//             : const Text(
//           'Press button to download',
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 20
//           ),
//         )
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _loading = !_loading;
//               _updateProgress();
//             });
//           },
//           child: const Icon(Icons.cloud_download),
//         ),
//       ),
//     );
//   }
//
//   void _updateProgress() {
//     const oneSec = Duration(seconds: 1);
//     Timer.periodic(oneSec, (Timer t) {
//       setState(() {
//         _progressValue += 0.2;
//
//         if (_progressValue.toStringAsFixed(1) == '1.0') {
//           _loading = false;
//           t.cancel();
//           _progressValue = 0.0;
//           return;
//         }
//       });
//     });
//   }
//
// }

























// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black
//         )
//       ),
//       home: const RandomWords(),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class RandomWords extends StatefulWidget {
//   const RandomWords({super.key});
//
//   @override
//   State<RandomWords> createState() => _RandomWordsState();
// }
//
// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18);
//   final _saved = <WordPair>{};
//
//   void _pushSaved() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (context) {
//           final tiles = _saved.map(
//             (pair) {
//               return ListTile(
//                 title: Text(
//                   pair.asPascalCase,
//                   style: _biggerFont,
//                 )
//               );
//             }
//           );
//           final divided = tiles.isNotEmpty
//             ? ListTile.divideTiles(
//                 context: context,
//                 tiles: tiles
//               ).toList()
//             : <Widget>[];
//
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Saved Suggestions'),
//             ),
//             body: ListView(children: divided),
//           );
//         }
//       )
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Startup Name Generator"),
//         actions: [
//           IconButton(
//             onPressed: _pushSaved,
//             icon: const Icon(Icons.list),
//             tooltip: 'Saved Suggestions',
//           ),
//         ],
//       ),
//       body: ListView.builder(
//           padding: const EdgeInsets.all(16.0),
//           itemBuilder: (context, i) {
//             if (i.isOdd) return const Divider();
//
//             final index = i ~/ 2;
//             if (index >= _suggestions.length) {
//               _suggestions.addAll(generateWordPairs().take(10));
//             }
//
//             final alreadySaved = _saved.contains(_suggestions[index]);
//
//             return ListTile(
//               title: Text(
//                 _suggestions[index].asPascalCase,
//                 style: _biggerFont,
//               ),
//               trailing: Icon(
//                 alreadySaved ? Icons.favorite : Icons.favorite_border,
//                 color: alreadySaved ? Colors.red : null,
//                 semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
//               ),
//               onTap: () {
//                 setState(() {
//                   if (alreadySaved) {
//                     _saved.remove(_suggestions[index]);
//                   } else {
//                     _saved.add(_suggestions[index]);
//                   }
//                 });
//               },
//             );
//           }
//       ),
//     );
//   }
// }
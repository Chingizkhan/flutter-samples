import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FirstScreenState();
  }

}

class _FirstScreenState extends State<FirstScreen> {
  String text = 'Some Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                text,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                _returnDataFromSecondScreen(context);
              },
              child: const Text(
                'Go to second screen',
                style: TextStyle(fontSize: 24)
              )
            )
          ],
        ),
      ),
    );
  }

  void _returnDataFromSecondScreen(BuildContext context) async {
    Route route = MaterialPageRoute(builder: (context) => SecondScreen());
    final result = await Navigator.push(context, route);

    setState(() {
      text = result;
    });
  }
}


class SecondScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SecondScreenState();
  }

}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: textFieldController,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                String textToSendBack = textFieldController.text;
                Navigator.pop(context, textToSendBack);
              },
              child: const Text(
                'Send text back',
                style: TextStyle(fontSize: 24)
              )
            )
          ],
        ),
      ),
    );
  }
}
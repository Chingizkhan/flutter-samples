import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _value = Provider.of<int>(context);

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'StreamProvider Example',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 50,),
            Text(_value.toString(), style: Theme.of(context).textTheme.displayMedium,),
          ],
        ),
      ),
    );
  }
}

class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 2);
    return Stream<int>.periodic(interval, (int _count) => _count++);
  }
}
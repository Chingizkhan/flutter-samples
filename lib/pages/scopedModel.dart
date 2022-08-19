import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelScreen extends StatefulWidget {
  const ScopedModelScreen({Key? key}) : super(key: key);

  @override
  State<ScopedModelScreen> createState() => _ScopedModelScreenState();
}

class _ScopedModelScreenState extends State<ScopedModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoped model'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ScopedModel<MyModelState>(
            model: MyModelState(),
            child: Column(
              children: const [
                _Counter(),
                _Counter()
              ],
            )
          ),
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModelState>(
      builder: (context, child, model) {
        return _cardCreate(context, model);
      },
      rebuildOnChange: true,
    );
  }
}

Card _cardCreate(BuildContext context, MyModelState model) {
  return Card(
    margin: const EdgeInsets.all(4.0).copyWith(bottom: 32.0),
    color: Colors.yellowAccent,
    child: Column(
      children: [
        const Text('(Child Widget)'),
        Text('${model.counterValue}', style: Theme.of(context).textTheme.displayMedium),
        ButtonBar(
          children: [
            IconButton(
              onPressed: () => model._decrementCounter(),
              color: Colors.red,
              icon: const Icon(Icons.remove)
            ),
            IconButton(
                onPressed: () => model._incrementCounter(),
                color: Colors.red,
                icon: const Icon(Icons.add)
            ),
          ],
        )
      ],
    ),
  );
}


class MyModelState extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }
  void _decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
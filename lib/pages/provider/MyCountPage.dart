import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCountPage extends StatelessWidget {
  const MyCountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider _state = Provider.of<CountProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ChangeNotifierProvider Example',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 50,),
            Text(
              '${_state.counterValue}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _state._decrementCount,
                  color: Colors.red,
                  icon: const Icon(Icons.remove)
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                        onPressed: () => value._incrementCount(),
                        color: Colors.green,
                        icon: const Icon(Icons.add)
                    );
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _count = 0;
  int get counterValue => _count;

  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}
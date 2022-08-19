import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHomeWork extends StatelessWidget {
  const ProviderHomeWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(value: AppState())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Homework Provider'),
          centerTitle: true,
        ),
        body: const Center(
          child: MyStatelessWidget(),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            state.changeSelected();
          },
          child: AnimatedContainer(
            width: 200,
            height: 200,
            color: state._selected ? Colors.red : Colors.blue,
            alignment: Alignment.center,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: const FlutterLogo(size: 75),
          ),
        ),
        Switch(
            value: state.getSelected,
            onChanged: (_) {
              state.changeSelected();
            }
        )
      ],
    );;
  }
}


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    AppState state = Provider.of<AppState>(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              state.changeSelected();
            });
          },
          child: AnimatedContainer(
            width: 200,
            height: 200,
            color: state._selected ? Colors.red : Colors.blue,
            alignment: Alignment.center,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: const FlutterLogo(size: 75),
          ),
        ),
        Switch(
          value: state.getSelected,
          onChanged: (_) {
            state.changeSelected();
          }
        )
      ],
    );
  }
}

class AppState extends ChangeNotifier {
  bool _selected = false;
  bool get getSelected => _selected;

  void changeSelected() {
    _selected = !_selected;
    notifyListeners();
  }
}
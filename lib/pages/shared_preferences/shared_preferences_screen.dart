import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreen extends StatelessWidget {
  const SharedPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared preferences demo'),
        centerTitle: true,
      ),
      body: const SharedPreferencesComponent(),
    );
  }
}

class SharedPreferencesComponent extends StatefulWidget {
  const SharedPreferencesComponent({Key? key}) : super(key: key);

  @override
  State<SharedPreferencesComponent> createState() => _SharedPreferencesComponentState();
}

class _SharedPreferencesComponentState extends State<SharedPreferencesComponent> {

  late SharedPreferences _prefs;

  static const String kNumberPrefKey = 'number_pref';
  static const String kBoolPrefKey = 'bool_pref';

  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      .then((prefs) {
        setState(() {
          _prefs = prefs;
        });
      }
    ).then((value) {
      _loadBoolPref();
      _loadNumberPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                const Text('Number Preferences'),
                Text('$_numberPref'),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      _numberPref = _numberPref++;
                    });
                    // _setNumberPref(_numberPref++);
                  },
                  child: const Text('Increment'),
                )
              ]
            ),
            TableRow(
              children: [
                const Text('Boolean Preferences'),
                Text('$_boolPref'),
                MaterialButton(
                  onPressed: () {
                    _setBoolPref(!_boolPref);
                  },
                  child: const Text('Toggle'),
                )
              ]
            )
          ],
        ),
        MaterialButton(
          onPressed: () {
            _prefs.clear();
          },
          child: const Text('Reset Data'),
        )
      ],
    );
  }

  Future<Null> _setNumberPref(int value) async {
    await _prefs.setInt(kNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await _prefs.setBool(kBoolPrefKey, value);
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      _numberPref = _prefs.getInt(kNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      _boolPref = _prefs.getBool(kBoolPrefKey) ?? false;
    });
  }
}

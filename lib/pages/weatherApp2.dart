import 'package:flutter/material.dart';

class WeatherApp2 extends StatelessWidget {
  const WeatherApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _headerCreate(),
        body: _bodyCreate(),
      ),
    );
  }
}

SafeArea _bodyCreate() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _inputCreate(),
                const Divider(),
                _currentWeatherCreate(),
                const Divider(),
                const Text('7-DAY WEATHER FORECAST')
              ],
          )),
          Expanded(child: _weatherListCreate())
        ],
      ),
    )
  );
}

Row _inputCreate() {
  return Row(
    children: const [
      Icon(Icons.search),
      Text('Enter City Name')
    ],
  );
}

Column _currentWeatherCreate() {
  return Column(
    children: const [
      Text('Kostanay region, KZ'),
      Text('Friday, Mar 20, 2022'),
    ],
  );
}

ListView _weatherListCreate() {
  final items = List.generate(7, (index) => Weather('Friday', '6 *F', const Icon(Icons.wb_sunny)));

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemExtent: 100,
    itemCount: 7,
    itemBuilder: (context, index) {
      final item = items[index];

      return _weatherListItem(item);
    }
  );
}

class Weather {
  final String day;
  final String temperature;
  final Icon icon;

  Weather(this.day, this.temperature, this.icon);
}

SizedBox _weatherListItem(Weather item) {
  return SizedBox(
    height: 40,
    child: Card(
      child: Column(
        children: [
          Text(item.day),
          Row(
            children: [
              Text(item.temperature),
              const Icon(Icons.wb_sunny, size: 20,)
            ],
          )
        ],
      ),
    )
  );
}

PreferredSizeWidget _headerCreate() {
  return AppBar(
    title: const Text('Weather Forecast'),
    centerTitle: true,
  );
}
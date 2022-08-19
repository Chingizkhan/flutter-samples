import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          decoration: const BoxDecoration(
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    title: const Text(
      'Weather',
      style: TextStyle(
          color: Colors.black87
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu),
      color: Colors.black54,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
        color: Colors.black54,
      )
    ],
  );
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _headerImage(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _weatherDescription(),
                const Divider(),
                _temperature(),
                const Divider(),
                _temperatureForecast(),
                const Divider(),
                _footerRatings()
              ],
            )
          )
        )
      ],
    ),
  );
}

Image _headerImage() {
  return const Image(
    image: NetworkImage('https://cdn.britannica.com/23/204523-138-A67F2633/more-weather-climate.jpg?w=800&h=450&c=crop'),
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text(
        "Tuesday - May 22",
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold
        ),
      ),
      Divider(color: Colors.black54,),
      Text(
        'Lorem ipsum dolor sit amet, lorem ipsum dolor sit amet, lorem ipsum dolor sit amet, lorem ipsum dolor sit amet, lorem ipsum dolor sit amet, lorem ipsum dolor sit amet, ',
        style: TextStyle(color: Colors.black54),
      )
    ],
  );
}

Row _temperature() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: const [
          Icon(Icons.wb_sunny, color: Colors.yellow,),
        ],
      ),
      const SizedBox(width: 16,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('15* Clear', style: TextStyle(color: Colors.deepPurple),)
            ],
          ),
          Row(
            children: const [
              Text('Kostanay region, Kostanay', style: TextStyle(color: Colors.grey),)
            ],
          )
        ],
      )
    ],
  );
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10,
    children: List.generate(8, (int index) {
      return Chip(
        label: Text(
          '${index + 20}*C',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        avatar: Icon(
          Icons.wb_cloudy,
          color: Colors.blue.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(color: Colors.grey),
        ),
        backgroundColor: Colors.grey.shade100,
      );
    }),
  );
}

Row _footerRatings() {
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, size: 15, color: Colors.yellow[600],),
      Icon(Icons.star, size: 15, color: Colors.yellow[600],),
      Icon(Icons.star, size: 15, color: Colors.yellow[600],),
      const Icon(Icons.star, size: 15, color: Colors.black,),
      const Icon(Icons.star, size: 15, color: Colors.black,)
    ],
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Text(
        'Info with openweathermap.org',
        style: TextStyle(
            fontSize: 15
        ),
      ),
      stars,
    ],
  );
}
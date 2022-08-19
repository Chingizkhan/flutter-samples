import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Routing and Navigation'),
          centerTitle: true,
        ),
        body: const HomePage(),
      ),
      // initialRoute: '/page2',
      // routes: {
      //   '/first': (context) => HomePage(),
      //   '/second': (context) => Page2(),
      // },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/second':
            User user = settings.arguments as User;
            return MaterialPageRoute(builder: (context) => Page2(user: user));
        }
      },

    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          // 1
          // User user = User(name: 'Konstantin', age: 34);
          // Route route = MaterialPageRoute(builder: (context) => Page2(user));
          // Navigator.push(context, route);

          // 2 & 3
          User user = User(name: 'Konstantin', age: 34);
          Navigator.pushNamed(context, '/second', arguments: user);
        },
        child: const Text('Move to Page 2'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  late final User user;

  Page2({required this.user});

  @override
  Widget build(BuildContext context) {

    // in case of using routes in MaterialApp, because MaterialApp gives access to RouteSettings
    // RouteSettings? settings = ModalRoute.of(context)?.settings;
    // user = settings?.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name} - ${user.age}"),
        centerTitle: true,
      ),
      body: Center(
        child: OutlinedButton(
          child: const Text('Go back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

}

class User {
  late final String? name;
  final int? age;

  User({ this.name, this.age });
}

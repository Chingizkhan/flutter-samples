import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyCountPage.dart';
import 'MyEventPage.dart';
import 'MyUserPage.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
        FutureProvider<List<User>>(create: (_) async => UserProvider().loadUserData(), initialData: []),
        StreamProvider(create: (_) => EventProvider().intStream(), initialData: 0)
      ],
      child: _defaultTabControllerCreate()
    );
  }
}

DefaultTabController _defaultTabControllerCreate() {
  return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBarCreate(),
        body: const TabBarView(
          children: [
            MyCountPage(),
            MyUserPage(),
            MyEventPage()
          ],
        ),
      )
  );
}

PreferredSizeWidget _appBarCreate() {
  return AppBar(
    title: const Text('Provider demo'),
    centerTitle: true,
    bottom: const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.add),),
        Tab(icon: Icon(Icons.person),),
        Tab(icon: Icon(Icons.message),)
      ],
    ),
  );
}
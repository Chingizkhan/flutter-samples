import 'package:flutter/material.dart';

class DynamicList extends StatelessWidget {
  const DynamicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic List'),
          centerTitle: true,
        ),
        body: BodyListView(),
      ),
    );
  }
}

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  final List<ListItem> items = List<ListItem>.generate(
      10000,
      (int i) => i % 6 == 0
        ? HeadingItem('Heading $i')
        : MessageItem('Sender $i', 'Message body $i')
  );

  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      if (item is HeadingItem) {
        return _headingTileCreate(context, item);
      } else {
        return _messageTileCreate(item as MessageItem);
      }
    },
  );
}

abstract class ListItem {

}

ListTile _messageTileCreate(MessageItem item) {
  return ListTile(
    title: Text(item.sender),
    subtitle: Text(item.body),
    leading: const Icon(Icons.insert_photo, color: Colors.red,),
    trailing: const Icon(Icons.keyboard_arrow_right),
  );
}

ListTile _headingTileCreate(context, HeadingItem item) {
  return ListTile(
    title: Text(
      item.heading,
      style: Theme.of(context).textTheme.headline5,
    ),
  );
}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}

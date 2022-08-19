import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/offices.dart';

class HttpRequestPage extends StatefulWidget {
  const HttpRequestPage({Key? key}) : super(key: key);

  @override
  State<HttpRequestPage> createState() => _HttpRequestPageState();
}

class _HttpRequestPageState extends State<HttpRequestPage> {

  late Future<OfficesList> officesList;

  @override
  void initState() {
    getOfficesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual JSON Serialization'),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.offices.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${snapshot.data?.offices[index].name}'),
                    subtitle: Text('${snapshot.data?.offices[index].address}'),
                    leading: Image.network('${snapshot.data?.offices[index].image}'),
                    isThreeLine: true,
                  ),
                );
              }
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Future<http.Response> getData() async {
  var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
  //  var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
  return await http.get(url);
}

void loadData() {
  getData().then((response) {
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }).catchError((error) {
    debugPrint(error.toString());
  });
}
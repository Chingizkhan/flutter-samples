import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class IOFile extends StatelessWidget {
  const IOFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local file read/write demo'),
        centerTitle: true,
      ),
      body: const IOFileContent(),
    );
  }
}


class IOFileContent extends StatefulWidget {
  const IOFileContent({Key? key}) : super(key: key);

  @override
  State<IOFileContent> createState() => _IOFileContentState();
}

class _IOFileContentState extends State<IOFileContent> {
  final TextEditingController _textController = TextEditingController();

  static const String kLocalFileName = 'demo_localfile.txt';
  String _localFileContent = '';
  String _localFilePath = kLocalFileName;

  @override
  void initState() {
    super.initState();
    _readTextFromLocalFile();
    _getLocalFile.then((file) => setState(() => _localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const Text('Write to local file:', style: TextStyle(fontSize: 20),),
        TextField(
          controller: _textController,
          focusNode: textFieldFocusNode,
          maxLines: null,
          style: const TextStyle(fontSize: 20),
        ),
        ButtonBar(
          children: [
            MaterialButton(
              onPressed: () async {
                await _readTextFromLocalFile();
                _textController.text = _localFileContent;
                FocusScope.of(context).requestFocus(textFieldFocusNode);
                log('String successfuly loaded from local file');
              },
              child: const Text('Load', style: TextStyle(fontSize: 20)),
            ),
            MaterialButton(
              onPressed: () async {
                await _writeTextToLocalFile(_textController.text);
                _textController.clear();
                await _readTextFromLocalFile();
                log('String successfuly written to local file');
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
        const Divider(height: 20,),
        Text('Local file path:', style: Theme.of(context).textTheme.titleMedium,),
        Text(_localFilePath, style: Theme.of(context).textTheme.subtitle1,),
        const Divider(height: 20,),
        Text('Local file content:', style: Theme.of(context).textTheme.titleMedium,),
        Text(_localFileContent, style: Theme.of(context).textTheme.subtitle1,),
      ],
    );
  }

  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _getLocalFile async {
    final path = await _getLocalPath;
    return File('$path/$kLocalFileName');
  }

  Future<File> _writeTextToLocalFile(String text) async {
    final file = await _getLocalFile;
    return file.writeAsString(text);
  }

  Future _readTextFromLocalFile() async {
    String content;
    try {
      final file = await _getLocalFile;
      content = await file.readAsString();
    } catch (e) {
      content = "error";
    }
    setState(() {
      _localFileContent = content;
    });
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  await dotenv.load();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String val = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: <Widget>[
          FlatButton(
            onPressed: () async {
              String url = dotenv.env['API_URL'] ?? 'API_URL not found';
// ignore: unnecessary_null_comparison
              if (url != 'API_URL not found') {
                final response = await http.get(Uri.parse(url + '/test'));
                final decoded =
                    json.decode(response.body) as Map<String, dynamic>;
                setState(() {
                  val = decoded['greetings'];
                });
              } else {
                print(url);
              }
            },
            child: Text('Click here to Get Message from Flask'),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(val)
        ]),
      ),
    );
  }
}

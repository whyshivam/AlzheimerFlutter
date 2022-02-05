// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
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
        child: Center(
          child: Column(children: <Widget>[
            Text('Printing here ${val}'),
            const SizedBox(
              height: 10.0,
            ),
            FlatButton(
              onPressed: () async {
                String url =
                    "http://127.0.0.1:5000"; // to be replaced using env var

                final response = await http.get(Uri.parse(url + '/test'));
                final decoded =
                    json.decode(response.body) as Map<String, dynamic>;
                setState(() {
                  val = decoded['greetings'];
                });
              },
              child: Text('Get from Flask'),
            ),
          ]),
        ),
      ),
    );
  }
}

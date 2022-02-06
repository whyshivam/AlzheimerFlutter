// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

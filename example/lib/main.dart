import 'package:flutter/material.dart';
import 'package:scorm/scorm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _foundApi = false;
  String _value = "";
  String _enteredValue = "";
  String _key = "cmi.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _foundApi = ScormAPI.findApi();
                  });
                },
                child: Text("Find API"),
              ),
              SizedBox(height: 10),
              RaisedButton(onPressed: _foundApi ? () => ScormAPI.initialize() : null, child: Text('Init')),
              SizedBox(height: 10),
              TextField(
                controller: TextEditingController(text: _key),
                onChanged: (newKey) => _key = newKey,
                decoration: InputDecoration(labelText: "Key"),
              ),
              TextField(
                controller: TextEditingController(text: _enteredValue),
                onChanged: (newValue) => _enteredValue = newValue,
                decoration: InputDecoration(labelText: "Value"),
              ),
              SizedBox(height: 10),
              RaisedButton(onPressed: _foundApi ? () => ScormAPI.setValue(_key, _enteredValue) : null, child: Text('Set Value')),
              SizedBox(height: 10),
              Text(_value ?? "null"),
              SizedBox(height: 5),
              RaisedButton(onPressed: _foundApi ? () => setState(() => _value = ScormAPI.getValue(_key)) : null, child: Text('Get Value')),
              SizedBox(height: 10),
              RaisedButton(onPressed: _foundApi ? () => ScormAPI.commit() : null, child: Text('Commit')),
              SizedBox(height: 10),
              RaisedButton(onPressed: _foundApi ? () => ScormAPI.finish() : null, child: Text('Finish')),
            ],
          ),
        ),
      ),
    );
  }
}

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
  ScormVersion? _version;
  bool _foundApi = false;
  String? _value;
  String _enteredValue = "";
  String _key = "cmi.";
  String? _lastError;
  String? _lastErrorString;
  String? _diagnosticMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<ScormVersion>(
                  value: _version,
                  items: [
                    DropdownMenuItem(child: Text("Auto"), value: null),
                    DropdownMenuItem(child: Text("v2004"), value: ScormVersion.v2004),
                    DropdownMenuItem(child: Text("v1.2"), value: ScormVersion.v1_2),
                  ],
                  onChanged: (newVersion) => setState(() => _version = newVersion),
                  hint: Text("Auto"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _foundApi = ScormAPI.findApi(version: _version);
                    });
                  },
                  child: Text("Find API"),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: _foundApi ? () => ScormAPI.initialize() : null, child: Text('Init')),
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
                ElevatedButton(onPressed: _foundApi ? () => ScormAPI.setValue(_key, _enteredValue) : null, child: Text('Set Value')),
                SizedBox(height: 10),
                Text(_value ?? "null"),
                SizedBox(height: 5),
                ElevatedButton(onPressed: _foundApi ? () => setState(() => _value = ScormAPI.getValue(_key)) : null, child: Text('Get Value')),
                SizedBox(height: 10),
                Text("Error Code: ${_lastError ?? "null"}"),
                SizedBox(height: 5),
                Text("Error String: ${_lastErrorString ?? "null"}"),
                SizedBox(height: 5),
                Text("Diagnostic Message: ${_diagnosticMessage ?? "null"}"),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: _foundApi
                      ? () => setState(() {
                            _lastError = ScormAPI.getLastError()!;
                            _lastErrorString = ScormAPI.getErrorString(_lastError!)!;
                            _diagnosticMessage = ScormAPI.getDiagnosticMessage(_lastError!)!;
                          })
                      : null,
                  child: Text('Get Last Error'),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: _foundApi ? () => ScormAPI.commit() : null, child: Text('Commit')),
                SizedBox(height: 10),
                ElevatedButton(onPressed: _foundApi ? () => ScormAPI.finish() : null, child: Text('Finish')),
                SizedBox(height: 10),
                Visibility(visible: ScormAPI.apiFound, child: Text(ScormAPI.version.toString())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

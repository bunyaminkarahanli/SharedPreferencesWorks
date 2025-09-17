import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _number = 0;

  Color _leftBox = Colors.transparent;
  Color _rightBox = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _loadNumber();
    _loadColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          32,
          32,
          32,
          MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 120, height: 120, color: _leftBox),
                Container(width: 120, height: 120, color: _rightBox),
              ],
            ),
            SizedBox(height: 50),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(()  {
                      _leftBox = Colors.yellow;
                      _rightBox = Colors.blueAccent;
                    });
                       _colorSaved();

                  },
                  child: Text(
                    'Fenerbahçe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  
                ),
                TextButton(onPressed: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                   prefs.remove('leftColor');
                   prefs.remove('rightColor');
                  setState(() {
                    _leftBox = Colors.transparent;
                    _rightBox = Colors.transparent;

                  });

                }, child: Text('Renklilere Ölüm')),
                TextButton(
                  onPressed: () {
                    setState(()  {
                      _leftBox = Colors.orange;
                      _rightBox = Colors.red;
                    });
                       _colorSaved();

                  },
                  child: Text(
                    '6alatasaray',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            IconButton(
              onPressed: () async {
                setState(() {
                  _number++;
                });
                await _savedNumber();
              },
              icon: Icon(Icons.arrow_upward, size: 62),
            ),
            SizedBox(height: 50),
            Text('$_number', style: TextStyle(fontSize: 42)),
            SizedBox(height: 50),
            IconButton(
              onPressed: () async {
                setState(() {
                  _number--;
                });
                await _savedNumber();
              },
              icon: Icon(Icons.arrow_downward, size: 62),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savedNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _number);
  }

  Future<void> _loadNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? counter = prefs.getInt('counter');
    setState(() {
      _number = counter ?? 0;
    });
  }

  Future<void> _colorSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('leftColor', _leftBox.value);
    await prefs.setInt('rightColor', _rightBox.value);
  }

  Future<void> _loadColor() async {
    final prefs = await SharedPreferences.getInstance();
    final leftValue = prefs.getInt('leftColor');
    final rightValue = prefs.getInt('rightColor');
    setState(() {
      _leftBox = leftValue!= null  ? Color(leftValue) : Colors.transparent;
      _rightBox = rightValue!= null  ? Color(rightValue) : Colors.transparent;
    });
  }
}

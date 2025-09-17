import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  int _numero = 0;
  @override
  void initState() {
    
    super.initState();
    _loadNumero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                setState(() {
                  _numero++;
                });
                _savedNumero();
              },
              icon: Icon(Icons.arrow_upward, size: 62),
            ),
            SizedBox(height: 50),
            Text('$_numero', style: TextStyle(fontSize: 42)),
            SizedBox(height: 50),
            IconButton(
              onPressed: () async {
                setState(() {
                  _numero--;
                });
                _savedNumero();

              },
              icon: Icon(Icons.arrow_downward, size: 62),
            ),
          ],
        ),
      ),
    );
  }
  
  Future <void> _savedNumero()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _numero);
  }
  
  Future <void> _loadNumero()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? counter =prefs.getInt('counter');
    setState(() {
      _numero = counter ?? 0;
    });

  }

}
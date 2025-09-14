import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _sayi = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Deneme Uygulaması",
      home: Scaffold(
        appBar: AppBar(title: const Text("Ana Sayfa")),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    _sayi++;
                  });
                  _saveCounter();
                },
                icon: Icon(Icons.arrow_upward, size: 62),
              ),
              SizedBox(height: 50),
              Text('$_sayi', style: TextStyle(fontSize: 42)),
              SizedBox(height: 50),
              IconButton(
                onPressed: () {
                  setState(() {
                    _sayi--;
                  });
                  _saveCounter();
                },
                icon: Icon(Icons.arrow_downward, size: 62),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _sayi);
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? saved = prefs.getInt('counter');
    setState(() {
      _sayi = saved ?? 0;
    });
  }
}

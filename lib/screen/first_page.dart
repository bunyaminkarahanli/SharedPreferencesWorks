import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _controller = TextEditingController();
  String _title = '';
  int _sayi = 0;
  

  @override
  void initState() {
    super.initState();
    _loadSayi();
    _loadTitle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            32,
            32,
            32,
            MediaQuery.of(context).viewInsets.bottom + 32,
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    _sayi++;
                  });
                  await _savedSayi();
                },
                icon: Icon(Icons.arrow_upward, size: 62, color: Colors.green),
              ),
              SizedBox(height: 30),
              Text('$_sayi', style: TextStyle(fontSize: 42)),
              SizedBox(height: 30),
              IconButton(
                onPressed: () async {
                  setState(() {
                    _sayi--;
                  });
                  await _savedSayi();
                },
                icon: Icon(Icons.arrow_downward, size: 62, color: Colors.red),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Başlık Gir',
                  hintText: 'Buraya Yazınız',
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: ()async {
                        setState(() {
                          _controller.clear();
                          _title = '';
                        });
                        await _savedTitle('');
                      },
                      child: const Text("Sil"),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async{
                        final text = _controller.text.trim();
                        setState(() => _title = text);
                        await _savedTitle(text);
                        _controller.clear();
                      },
                      child: const Text("Gönder"),
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _savedSayi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _sayi);
  }

  Future<void> _loadSayi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('counter');
    setState(() {
      _sayi = counter ?? 0;
    });
  }
  
  Future <void> _savedTitle(String value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('action', _controller.text);
  }
  
  Future <void> _loadTitle()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');
    setState(() {
      _title = action ?? '';
    });

  }
}

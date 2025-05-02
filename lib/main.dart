import 'package:flutter/material.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'البحث في مسببات الأمراض',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(bodyText2: TextStyle(fontSize: 16)),
      ),
      home: PathogenSearchScreen(),
    );
  }
}

class PathogenSearchScreen extends StatefulWidget {
  @override
  _PathogenSearchScreenState createState() => _PathogenSearchScreenState();
}

class _PathogenSearchScreenState extends State<PathogenSearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final filtered = pathogenData.where((row) =>
      row.any((cell) => cell.toLowerCase().contains(query.toLowerCase()))
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text('🔍 البحث في مسببات الأمراض')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن اسم كائن أو طعام أو عرض...',
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return Card(
                  child: ListTile(
                    title: Text(item[1], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('الأطعمة: ${item[5]}\nالأعراض: ${item[3]}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

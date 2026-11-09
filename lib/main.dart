import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('requests');
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box('requests');
  final title = TextEditingController();
  bool isAdmin = false;
  final states = ['Pending', 'In Progress', 'Resolved'];

  void msg(String t) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));

  void add() {
    if (title.text.trim().isEmpty) return msg('Title required');
    box.add({'title': title.text.trim(), 'status': 'Pending'});
    title.clear();
  }

  void next(dynamic key) {
    if (!isAdmin) return msg('Admin only');
    final r = Map.from(box.get(key));
    r['status'] = states[(states.indexOf(r['status']) + 1) % 3];
    box.put(key, r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin ? 'Admin' : 'Student'),
        actions: [
          Switch(value: isAdmin, onChanged: (v) => setState(() => isAdmin = v))
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: title,
                decoration: const InputDecoration(hintText: 'e.g. Broken AC'),
              ),
            ),
            IconButton(icon: const Icon(Icons.add), onPressed: add),
          ]),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, b, child) => ListView(
              children: [
                for (final k in b.keys)
                  ListTile(
                    title: Text(b.get(k)['title']),
                    subtitle: Text(b.get(k)['status']),
                    onTap: () => next(k),
                  ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
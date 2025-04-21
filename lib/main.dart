
import 'package:flutter/material.dart';
import 'entry_form.dart';
import 'entry_model.dart';
import 'storage_service.dart';

void main() {
  runApp(const MampfmonitorApp());
}

class MampfmonitorApp extends StatelessWidget {
  const MampfmonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mampfmonitor',
      theme: ThemeData.dark(useMaterial3: true),
      home: const EntryListScreen(),
    );
  }
}

class EntryListScreen extends StatefulWidget {
  const EntryListScreen({super.key});

  @override
  State<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    StorageService.loadEntries().then((loaded) {
      setState(() {
        entries = loaded;
      });
    });
  }

  void _addEntry(Entry entry) {
    setState(() {
      entries.add(entry);
      StorageService.saveEntries(entries);
    });
  }

  void _openForm() async {
    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => EntryForm()));
    if (result != null && result is Entry) {
      _addEntry(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mampfmonitor')),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(entries[index].meal ?? 'Eintrag'),
          subtitle: Text(entries[index].notes ?? ''),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}

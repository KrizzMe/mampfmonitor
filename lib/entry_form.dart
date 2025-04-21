import 'package:flutter/material.dart';
import 'entry_model.dart';

class EntryFormScreen extends StatefulWidget {
  const EntryFormScreen({super.key});

  @override
  State<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mealController = TextEditingController();
  final _complaintsController = TextEditingController();
  final _medicationController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDateTime = DateTime.now();

  @override
  void dispose() {
    _mealController.dispose();
    _complaintsController.dispose();
    _medicationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final newEntry = Entry(
        meal: _mealController.text,
        complaints: _complaintsController.text,
        medication: _medicationController.text,
        notes: _notesController.text,
        timestamp: _selectedDateTime,
      );
      Navigator.pop(context, newEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neuer Eintrag')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _mealController,
                decoration: const InputDecoration(labelText: 'Mahlzeit'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Bitte gib eine Mahlzeit ein'
                    : null,
              ),
              TextFormField(
                controller: _complaintsController,
                decoration: const InputDecoration(labelText: 'Beschwerden'),
              ),
              TextFormField(
                controller: _medicationController,
                decoration: const InputDecoration(labelText: 'Medikamente'),
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notizen'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Text(
                'Zeitpunkt: ${_selectedDateTime.toLocal().toString().split('.')[0]}',
                style: const TextStyle(fontSize: 16),
              ),
              TextButton.icon(
                onPressed: _selectDateTime,
                icon: const Icon(Icons.access_time),
                label: const Text('Datum & Uhrzeit ändern'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveEntry,
                icon: const Icon(Icons.save),
                label: const Text('Speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

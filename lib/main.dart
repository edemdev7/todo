import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, dynamic>> _todoItems = [
    {'title': 'Do exercise', 'time': '6.00 am', 'completed': true},
    {'title': 'Buy vegetables', 'time': '8.00 am', 'completed': true},
    {'title': 'Make veg salad', 'time': '10.00 am', 'completed': true},
    {'title': 'Go to shopping', 'time': '11.00 am', 'completed': false},
    {'title': 'Pay bills', 'time': '2.00 pm', 'completed': false},
    {'title': 'Go to walking', 'time': '6.00 pm', 'completed': false},
    {'title': 'Check email', 'time': '7.00 pm', 'completed': false},
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Méthode pour obtenir la date et l'heure actuelles
  String getCurrentDateTime() {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, d MMMM y').format(now);
    return '$formattedDate ';
  }

  // Fonction pour ajouter une nouvelle tâche
  void _addNewTask(String title, String time) {
    setState(() {
      _todoItems.add({'title': title, 'time': time, 'completed': false});
    });
    Navigator.of(context).pop();
    _titleController.clear();
    _timeController.clear();
  }

  // Fonction pour basculer l'état d'une tâche (complétée ou non)
  void _toggleTaskCompletion(int index) {
    setState(() {
      _todoItems[index]['completed'] = !_todoItems[index]['completed'];
    });
  }

  // Formulaire pour ajouter une nouvelle tâche
  Future<void> _showAddTaskDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Add New Task',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Task Title',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  hintText: 'Time (e.g., 10.00 am)',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.teal)),
            ),
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  _addNewTask(_titleController.text, _timeController.text);
                }
              },
              child: const Text('Add', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            // child: Icon(Icons.more_vert),
          ),
        ],
        title: const Text(
          'Todo List',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              getCurrentDateTime(),
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  final item = _todoItems[index];
                  return TodoItem(
                    title: item['title'],
                    time: item['time'],
                    completed: item['completed'],
                    onToggle: () => _toggleTaskCompletion(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final String title;
  final String time;
  final bool completed;
  final VoidCallback onToggle;

  const TodoItem({
    super.key,
    required this.title,
    required this.time,
    this.completed = false,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              completed ? Icons.check_circle : Icons.radio_button_unchecked,
              color: completed ? Colors.teal : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: completed ? Colors.grey : Colors.white,
                fontSize: 18,
                decoration: completed ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

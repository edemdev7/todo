import 'package:flutter/material.dart';

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

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

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
            child: Icon(Icons.more_vert),
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
            const Text(
              'March 4, 2010',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  TodoItem(
                    title: 'Do exercise',
                    time: '6.00 am',
                    completed: true,
                  ),
                  TodoItem(
                    title: 'Buy vegetables',
                    time: '8.00 am',
                    completed: true,
                  ),
                  TodoItem(
                    title: 'Make veg salad',
                    time: '10.00 am',
                    completed: true,
                  ),
                  TodoItem(
                    title: 'Go to shopping',
                    time: '11.00 am',
                    completed: false,
                  ),
                  TodoItem(
                    title: 'Pay bills',
                    time: '2.00 pm',
                    completed: false,
                  ),
                  TodoItem(
                    title: 'Go to walking',
                    time: '6.00 pm',
                    completed: false,
                  ),
                  TodoItem(
                    title: 'Check email',
                    time: '7.00 pm',
                    completed: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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

  const TodoItem({
    super.key,
    required this.title,
    required this.time,
    this.completed = false,
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
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.teal : Colors.grey,
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

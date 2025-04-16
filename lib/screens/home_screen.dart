import 'user_list_screen.dart';
import 'hey_cloudy_screen.dart';
import 'create_user_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoRest API Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("➕ Create User"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateUserScreen()),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("👥 View User"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserListScreen()),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Hey Cloudy "),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HeyCloudy()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

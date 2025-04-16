import '../services/api_service.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService.fetchUsers(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, i) {
              var user = snapshot.data![i];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['email']),
                trailing: Text(user['gender']),
              );
            },
          );
        },
      ),
    );
  }
}

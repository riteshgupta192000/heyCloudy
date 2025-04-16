import '../services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _gender = 'male';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var result = await ApiService.createUser(
        name: _nameController.text,
        email: _emailController.text,
        gender: _gender,
      );

      if (result != null) {
        Fluttertoast.showToast(
          msg: "User Created! ID: ${result['id']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to create user",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (val) => val!.isEmpty ? 'Name is required' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Email required';
                final emailReg = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$");
                return emailReg.hasMatch(val) ? null : 'Invalid email';
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: ['male', 'female']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) => setState(() => _gender = val!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitForm, child: const Text('Submit')),
          ]),
        ),
      ),
    );
  }
}

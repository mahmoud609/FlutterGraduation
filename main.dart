import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> _sendDataToAPI() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final url = Uri.parse("https://localhost:7030/api/User");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": _nameController.text,
        "email": _emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup successful!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF151644),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text("Create New Account", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildTextField(Icons.person, "Username", _nameController),
              SizedBox(height: 10),
              _buildTextField(Icons.email, "Email", _emailController),
              SizedBox(height: 10),
              _buildTextField(Icons.phone, "Phone", TextEditingController()),
              SizedBox(height: 10),
              _buildGenderField(),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF196AB3), padding: EdgeInsets.symmetric(horizontal: 50, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                onPressed: _sendDataToAPI,
                child: Text("Sign In", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, TextEditingController controller, {bool readOnly = false, VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      value: null,
      dropdownColor: Color(0xFF151644),
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Gender",
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.wc, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: ["Male", "Female"].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
      onChanged: (value) {},
    );
  }
}

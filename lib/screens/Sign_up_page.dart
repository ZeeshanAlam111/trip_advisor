import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_advisor/screens/home_screen.dart';
import 'package:travel_advisor/screens/log_in_page.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _name = '', _gender = '';
  DateTime? _dateOfBirth;
  String? _selectedGender;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),),
      ),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Full Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value.trim();
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
              // DatePicker to select the date of birth
              ElevatedButton(
                onPressed: () async {
                  _dateOfBirth = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                },
                child: Text(_dateOfBirth == null
                    ? "Select your date of birth"
                    : "Date of Birth: ${_dateOfBirth.toString().split(' ')[0]}"),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: ["Male", "Female", "Other"]
                    .map((label) => DropdownMenuItem<String>(
                  child: Text(label),
                  value: label,
                ))
                    .toList(),
                hint: Text("Gender"),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),


              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUp();
                  }
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': _name,
          'email': _email,
          'date_of_birth': _dateOfBirth,

          'gender': _gender,
        });

        Fluttertoast.showToast(
          msg: "Successfully signed up!",
          timeInSecForIosWeb: 1,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: e.toString(),
        timeInSecForIosWeb: 1,
      );
    }
  }
}

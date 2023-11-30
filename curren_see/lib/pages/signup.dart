import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUp({super.key, required this.showLoginPage});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    userEmail.dispose();
    userPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail.text.trim(),
        password: userPassword.text.trim(),
      );
    }
  }

  bool passwordConfirmed()
  {
    if (userPassword.text.trim() == confirmPassword.text.trim())
      {
        return true;
      }
    else
      {
        return false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100,),

              const SizedBox(height: 25,),

              const Text(
                'C U R R E N S E E',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10,),

              const Text('Create Your Account Here'),

              const SizedBox(height: 40,),

              TextFormField(
                controller: userEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                  prefixIcon: const Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 10,),

              TextFormField(
                controller: userPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  prefixIcon: const Icon(Icons.password),
                ),
              ),

              const SizedBox(height: 10,),

              TextFormField(
                controller: confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Confirm Password',
                  hintText: 'Enter Confirm Password',
                  prefixIcon: const Icon(Icons.password),
                ),
              ),

              const SizedBox(height: 40,),

              GestureDetector(
                onTap: () {
                  signUp();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white70
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: const Text(
                      'Login Here',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

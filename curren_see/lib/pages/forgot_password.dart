import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final userEmail = TextEditingController();

  @override
  void dispose() {
    userEmail.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try
    {
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(userEmail.text.trim());

      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: userEmail.text.trim()
      );
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password Reset Link Send Kindly Check Your Email'),
            );
          }
      );
    } on FirebaseAuthException catch (e) {
        print(e);
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            }
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_reset_outlined, size: 100,),

          const SizedBox(height: 25,),

          const Text(
            'C U R R E N S E E',
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 20,),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter Your Email First then we will send password reset link',
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
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
          ),

          const SizedBox(height: 10,),

          MaterialButton(
            onPressed: () => passwordReset(),
            color: Colors.black,
            child: const Text(
              'Reset Password',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}

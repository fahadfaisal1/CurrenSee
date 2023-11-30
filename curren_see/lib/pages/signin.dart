import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const SignIn({super.key, required this.showRegisterPage});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail.text.trim(),
        password: userPassword.text.trim()
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error during Google sign in: $error');
    }
  }


  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          final AccessToken accessToken = result.accessToken!;
          final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
          return await FirebaseAuth.instance.signInWithCredential(credential);

        case LoginStatus.cancelled:
          print('Facebook login cancelled');
          return null;

        case LoginStatus.failed:
          print('Facebook login failed: ${result.message}');
          return null;

        case LoginStatus.operationInProgress:
          print('Facebook login operation already in progress');
          return null;
      }
    } catch (error) {
      print('Error during Facebook login: $error');
      return null;
    }
  }


  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     return await _auth.signInWithCredential(credential);
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }

  @override
  void dispose() {
    userEmail.dispose();
    userPassword.dispose();
    super.dispose();
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
              const Icon(Icons.lock_person, size: 100,),

              const SizedBox(height: 25,),

              const Text(
                'C U R R E N S E E',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

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

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const ForgotPasswordPage();
                      }));
                    },
                      child: const Text('Forgot Password?')
                  ),
                ],
              ),

              const SizedBox(height: 25,),

              GestureDetector(
                onTap: () {
                  signIn();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Center(
                    child: Text(
                      'Login',
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
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Or continue with'),
                    ),

                    Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _handleSignIn,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200]
                      ),
                      child: Image.asset('assets/google.png', height: 40,)
                    ),
                  ),

                  const SizedBox(width: 10,),

                  GestureDetector(
                    onTap: signInWithFacebook,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[200]
                        ),
                        child: Image.asset('assets/facebook.png', height: 40,)
                    ),
                  ),
                ],
              ),



              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: const Text(
                      'Register Here',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
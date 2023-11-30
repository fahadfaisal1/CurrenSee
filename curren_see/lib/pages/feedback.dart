import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  final name = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final feedbackMsg = TextEditingController();

  void saveFeedback()
  {
    try
    {
      Map<String, dynamic> d = {
        "name": name.text.toString(),
        "email": email.text.toString(),
        "number": number.text.toString(),
        "feedbackMsg": feedbackMsg.text.toString(),
      };
      FirebaseFirestore.instance.collection("tbl_feedback").add(d);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Feedback Submitted')));
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Feedback Not Submitted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C U R R E N S E E'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.feedback, size: 100,),

            const SizedBox(height: 25,),

            const Text(
              'F E E D B A C K',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 40,),

            TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Name',
                hintText: 'Enter Your Name',
                prefixIcon: const Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 10),

            TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Email',
                hintText: 'Enter Your Email',
                prefixIcon: const Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 10),

            TextFormField(
              controller: number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Number',
                hintText: 'Enter Your Number',
                prefixIcon: const Icon(Icons.call),
              ),
            ),

            const SizedBox(height: 10),

            TextFormField(
              controller: feedbackMsg,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Feedback',
                hintText: 'Enter Your Feedback',
              ),
            ),

            const SizedBox(height: 25,),

            GestureDetector(
              onTap: () {
                saveFeedback();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                ),
                padding: const EdgeInsets.all(25),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white70
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
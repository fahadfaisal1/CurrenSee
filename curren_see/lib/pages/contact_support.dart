import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({super.key});

  @override
  State<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {

  final name = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();

  void contactSupport()
  {
    try
    {
      Map<String, dynamic> d = {
        "name": name.text.toString(),
        "email": email.text.toString(),
        "feedbackMsg": message.text.toString(),
      };
      FirebaseFirestore.instance.collection("tbl_contact_support").add(d);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message Submitted')));
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message Not Submitted')));
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

              const Icon(Icons.message, size: 100,),

              const SizedBox(height: 25,),

              const Text(
                'C O N T A C T S U P P O R T',
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
                controller: message,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Message',
                  hintText: 'Enter Your Message',
                ),
              ),

              const SizedBox(height: 25,),

              GestureDetector(
                onTap: () {
                  contactSupport();
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

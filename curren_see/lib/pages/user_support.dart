import 'package:curren_see/pages/contact_support.dart';
import 'package:flutter/material.dart';

class UserSupport extends StatefulWidget {
  const UserSupport({super.key});

  @override
  State<UserSupport> createState() => _UserSupportState();
}

class _UserSupportState extends State<UserSupport> {
  final List<Map<String, String>> faqs = [
    {'question': 'How do I reset my password?', 'answer': 'You can reset your password by visiting the settings page and selecting the "Forgot Password" option.'},
    {'question': 'Is my data secure?', 'answer': 'Yes, we take security seriously. Your data is encrypted and stored securely on our servers.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C U R R E N S E E'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          const Icon(Icons.contact_phone, size: 100,),

          const SizedBox(height: 25,),

          const Center(
            child: Text(
              'F A Qs',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(height: 30.0),

          for (var faq in faqs)
            ExpansionTile(
              title: Text(faq['question']!),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faq['answer']!,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20.0),

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactSupport()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12)
              ),
              padding: const EdgeInsets.all(25),
              child: const Center(
                child: Text(
                  'Contact Support',
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
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyNews extends StatefulWidget {
  @override
  _CurrencyNewsState createState() => _CurrencyNewsState();
}

class _CurrencyNewsState extends State<CurrencyNews> {
  final String apiKey = '008549b0e9b241b895546f23f95d1b1c';
  late Future<List<Map<String, dynamic>>> newsArticles;

  @override
  void initState() {
    super.initState();
    newsArticles = fetchCurrencyNews();
  }

  Future<List<Map<String, dynamic>>> fetchCurrencyNews() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=currency&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articles = data['articles'];
      return articles.cast<Map<String, dynamic>>(); // Ensure the list is of the correct type
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency News'),
      ),
      body: FutureBuilder(
        future: newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> articles = snapshot.data as List<Map<String, dynamic>>;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> article = articles[index];
                return ListTile(
                  title: Text(article['title'] ?? ''),
                  subtitle: Text(article['description'] ?? ''),
                  onTap: () {
                    // Implement the action when a news article is tapped
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

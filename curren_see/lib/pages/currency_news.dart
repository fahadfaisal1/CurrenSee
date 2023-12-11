import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
      return articles.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C U R R E N S E E'),
      ),
      body: FutureBuilder(
        future: newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> articles =
            snapshot.data as List<Map<String, dynamic>>;

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> article = articles[index];
                return ListTile(
                  title: Text(article['title'] ?? ''),
                  subtitle: Text(article['description'] ?? ''),
                  leading: article['urlToImage'] != null
                      ? Image.network(
                    article['urlToImage'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    'https://via.placeholder.com/80x80.png?text=No+Image',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  onTap: () => _launchURL(article['url']), // Open the article URL
                );
              },
            );
          }
        },
      ),
    );
  }

  // Function to launch the URL in a web browser
  _launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the case where the URL is empty or not available
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Article URL not available'),
        ),
      );
    }
  }
}
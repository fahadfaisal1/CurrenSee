import 'package:flutter/material.dart';
import 'firebase_messaging.dart';

class RateAlerts extends StatefulWidget {
  @override
  _RateAlertsState createState() => _RateAlertsState();
}

class _RateAlertsState extends State<RateAlerts> {
  final FirebaseMessagingService _messagingService = FirebaseMessagingService();
  final TextEditingController _currencyPairController = TextEditingController();
  final TextEditingController _thresholdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messagingService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C U R R E N S E E'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _currencyPairController,
              decoration: const InputDecoration(labelText: 'Currency Pair (e.g., USD/EUR)'),
            ),
            TextField(
              controller: _thresholdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Threshold'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _subscribeToRateAlert();
              },
              child: const Text('Set Rate Alert'),
            ),
          ],
        ),
      ),
    );
  }

  void _subscribeToRateAlert() {
    final currencyPair = _currencyPairController.text;
    final threshold = double.tryParse(_thresholdController.text);

    if (currencyPair.isNotEmpty && threshold != null) {
      final topic = '$currencyPair@$threshold';
      _messagingService.subscribeToTopic(topic);
      _showAlert('Rate Alert Set', 'You will receive notifications when the rate reaches $threshold for $currencyPair.');
    } else {
      _showAlert('Error', 'Invalid input. Please enter valid currency pair and threshold.');
    }
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

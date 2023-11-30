import 'package:flutter/material.dart';
import 'package:curren_see/conversion/fetchrates.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ConversionHistoryItem {
  final DateTime date;
  final String amount;
  final String fromCurrency;
  final String toCurrency;
  final String result;

  ConversionHistoryItem({
    required this.date,
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
    required this.result,
  });
}

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;

  const AnyToAny({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _AnyToAnyState createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  TextEditingController fromCurrencyController = TextEditingController();
  TextEditingController toCurrencyController = TextEditingController();
  String answer = 'Converted Currency will be shown here :)';

  List<ConversionHistoryItem> conversionHistory = [];

  Map<String, String> currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'AUD': 'A\$',
    'CAD': 'CA\$',
    'CHF': 'Fr.',
    'CNY': '¥',
    'SEK': 'kr',
    'NZD': 'NZ\$',
    'KRW': '₩',
    'SGD': 'S\$',
    'NOK': 'kr',
    'MXN': 'Mex\$',
    'BRL': 'R\$',
    'INR': '₹',
    'RUB': '₽',
    'ZAR': 'R',
    'TRY': '₺',
    'HKD': 'HK\$',
    'IDR': 'Rp',
    'PLN': 'zł',
    'PHP': '₱',
    'THB': '฿',
    'MYR': 'RM',
    'HUF': 'Ft',
    'CZK': 'Kč',
    'ILS': '₪',
    'DKK': 'kr',
    'AED': 'د.إ',
    'ARS': 'ARS\$',
    'CLP': 'CLP\$',
    'COP': 'COL\$',
    'EGP': 'EGP',
    'ILS': '₪',
    'INR': '₹',
    'KWD': 'KWD',
    'LKR': 'LKR',
    'NGN': '₦',
    'OMR': 'OMR',
    'PEN': 'S/.',
    'QAR': 'QAR',
    'SAR': 'SAR',
    'TWD': 'NT\$',
    'UAH': '₴',
    'VND': '₫',
    'XAF': 'FCFA',
    'BGN': 'лв',
    'HRK': 'kn',
    'RON': 'lei',
    'ISK': 'kr',
    'MKD': 'ден',
    'BHD': 'BHD',
    'CSD': 'CSD',
    'EEK': 'EEK',
    'KZT': '₸',
    'LTL': 'Lt',
    'LVL': 'Ls',
    'MVR': 'MVR',
    'MUR': 'MUR',
    'PKR': '₨',
    'RSD': 'RSD',
    'SDD': 'SDD',
    'SZL': 'SZL',
    'AFN': '؋',
    'ALL': 'L',
    'AMD': '֏',
    'AOA': 'Kz',
    'XCD': 'EC\$',
    'XOF': 'CFA',
    'XPF': 'CFP',
    'YER': '﷼',
    'ZMW': 'ZK',
    'ZWL': 'Z\$',
    'GEL': '₾',
    'GNF': 'GNF',
    'GYD': 'GYD',
    'HTG': 'HTG',
    'HNL': 'L',
    'HRK': 'kn',
    'HTG': 'HTG',
    'HUF': 'Ft',
    'IDR': 'Rp',
    'ILS': '₪',
    'IMP': 'IMP',
    'IQD': 'IQD',
    'IRR': 'IRR',
    'ISK': 'kr',
    'JEP': 'JEP',
    'JMD': 'JMD',
    'JOD': 'JOD',
    'KES': 'KES',
    'KGS': 'с',
    'KHR': '៛',
    'KID': 'KID',
    'KRW': '₩',
    'KWD': 'KWD',
    'KYD': 'KYD',
    'KZT': '₸',
    'LAK': '₭',
    'LBP': 'LBP',
    'LKR': 'LKR',
    'LRD': 'LRD',
    'LSL': 'LSL',
    'LTL': 'Lt',
    'LVL': 'Ls',
    'LYD': 'LYD',
    'MAD': 'MAD',
    'MDL': 'MDL',
    'MGA': 'MGA',
    'MKD': 'MKD',
    'MMK': 'MMK',
    'MNT': '₮',
    'MOP': 'MOP',
    'MRO': 'MRU',
    'MUR': 'MUR',
    'MVR': 'MVR',
    'MWK': 'MWK',
    'MXN': 'Mex\$',
  };

  String getCurrencyNameWithSymbol(String currencyCode) {
    if (currencySymbols.containsKey(currencyCode)) {
      return '$currencyCode - ${currencySymbols[currencyCode]}';
    } else {
      return currencyCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Convert Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Amount',
                hintText: 'Enter Your Amount',
                prefixIcon: const Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updateConversion();
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: fromCurrencyController,
                      decoration: InputDecoration(
                        labelText: 'From Currency',
                        hintText: 'Select From Currency',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return widget.currencies.keys
                          .where((currency) =>
                          currency.toLowerCase().contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(getCurrencyNameWithSymbol(suggestion)),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        fromCurrencyController.text = suggestion;
                      });
                      updateConversion();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To'),
                ),
                Expanded(
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: toCurrencyController,
                      decoration: InputDecoration(
                        labelText: 'To Currency',
                        hintText: 'Select To Currency',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return widget.currencies.keys
                          .where((currency) =>
                          currency.toLowerCase().contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(getCurrencyNameWithSymbol(suggestion)),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        toCurrencyController.text = suggestion;
                      });
                      updateConversion();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            MaterialButton(
              onPressed: () {
                showConversionHistory(context);
              },
              color: Colors.black,
              child: const Text(
                'View History',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              onPressed: () {
                showExchangeRateInfo(context);
              },
              color: Colors.black,
              child: const Text(
                'View Exchange Rate Info',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Container(child: Text(answer)),
          ],
        ),
      ),
    );
  }

  void updateConversion() {
    String amount = amountController.text.trim();
    String fromCurrency = fromCurrencyController.text.trim();
    String toCurrency = toCurrencyController.text.trim();

    if (amount.isEmpty || fromCurrency.isEmpty || toCurrency.isEmpty) {
      setState(() {
        answer = ''; // Clear the result when any field is empty
      });
      return;
    }

    String result = convertany(
      widget.rates,
      amount,
      fromCurrency,
      toCurrency,
    );

    String conversionDetails =
        '$amount ${getCurrencyNameWithSymbol(fromCurrency)} to ${getCurrencyNameWithSymbol(toCurrency)}: $result';

    setState(() {
      answer =
      '$conversionDetails ${currencySymbols[toCurrency] ?? toCurrency}';
      conversionHistory.add(ConversionHistoryItem(
        date: DateTime.now(),
        amount: amount,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        result: result,
      ));
    });
  }

  void showConversionHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conversion History'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...conversionHistory.reversed.map((historyItem) => Text(
                  '${historyItem.date.toString()} - ${historyItem.amount} ${getCurrencyNameWithSymbol(historyItem.fromCurrency)} to ${getCurrencyNameWithSymbol(historyItem.toCurrency)}: ${historyItem.result}',
                )),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      conversionHistory.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  color: Colors.black,
                  child: const Text(
                    'Clear History',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showExchangeRateInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exchange Rate Information'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Base Currency: USD'), // Replace 'USD' with your actual base currency
                SizedBox(height: 10),
                Text('Date: ${DateTime.now().toString()}'), // Show the current date, replace it with your actual date
                SizedBox(height: 10),
                Text('Exchange Rates:'),
                ...widget.rates.entries.map((entry) => Text(
                  '${entry.key}: ${entry.value.toString()}',
                )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

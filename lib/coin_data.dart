import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiCoinUrl = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = 'D8640CA3-CB50-438E-8A0A-2379168564A4';

class CoinData {
  Future<Map<String, double>> getCoinData(String currency) async {
    Map<String, double> rates = Map();
    for (String crypto in cryptoList) {
      http.Response response = await http.get('$apiCoinUrl$crypto/$currency?apiKey=$apiKey');
      print(jsonDecode(response.body));
      rates.putIfAbsent(crypto, () => double.parse(jsonDecode(response.body)['rate'].toString()));
    }
    return rates;
  }
}

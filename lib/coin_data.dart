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

const apiCoinUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
const apiKey = 'D8640CA3-CB50-438E-8A0A-2379168564A4';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    http.Response response = await http.get('$apiCoinUrl$currency?apiKey=$apiKey');
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      return 'Request error';
    }
  }
}

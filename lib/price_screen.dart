import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrecncy = 'EUR';
  int selectedIndexPicker = 4;
  CoinData coinData = CoinData();
  Map<String, double> rates = Map();

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      list.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrecncy,
      items: list,
      onChanged: (value) {
        setState(() {
          selectedCurrecncy = value;
          getRate();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> list = [];
    for (String currency in currenciesList) {
      list.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrecncy = currenciesList[selectedIndex];
        });
      },
      children: list,
    );
  }

  List<Widget> getCurrecnyContainer() {
    List<Widget> widgets = [];
    for (String crypto in cryptoList) {
      widgets.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = ${rates[crypto] == null ? '?' : rates[crypto].toStringAsFixed(2)} $selectedCurrecncy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  void getRate() async {
    rates.clear();
    var ratesResponse = await coinData.getCoinData(selectedCurrecncy);
    setState(() {
      rates = ratesResponse;
    });
  }

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCurrecnyContainer(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}

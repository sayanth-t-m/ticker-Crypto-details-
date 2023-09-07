import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(debugShowCheckedModeBanner: false,
      color: Colors.blue,
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData.dark(),
          darkTheme: ThemeData.dark(),
          themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const Duck(),
        );
      },
    );
  }
}

// Rest of the code...

class Duck extends StatefulWidget {
  const Duck({Key? key});

  @override
  State<Duck> createState() => _DuckState();
}

class _DuckState extends State<Duck> {
  static const ktext1 = TextStyle(
    color: Color(0xFFFFFFFF),
    letterSpacing: 20,
    fontSize: 30,
    fontWeight: FontWeight.w200,
    shadows: [
      Shadow(color: Colors.black, offset: Offset(1.5, 1.5), blurRadius: 5.5)
    ],
  );

  FixedExtentScrollController scrollController = FixedExtentScrollController();
  bool isLoading = false;
  Map<String, dynamic> coinData = {};
  List<String> coinOptions = [
    'bitcoin',
    'ethereum',
    'litecoin',
    'dogecoin',
    'tether',
    'pepe',
    'cardano',
    'ripple',
    'polkadot',
    'chainlink',
    'binancecoin',
    'stellar',
  ];

  String selectedCoin = 'bitcoin';
  bool isNightModeEnabled = false;

  void fetchCoinMarketData(String coinId) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$coinId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        coinData = data[0] as Map<String, dynamic>;
        isLoading = false;
      });
    } else {
      setState(() {
        coinData = {};
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 6,
        centerTitle: true,
        title: const Text(
          'Nyx',
          style: ktext1,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  spreadRadius: 8,
                  blurRadius: 10,
                  offset: Offset(0, 0), // changes the position of the shadow
                ),
              ],
              borderRadius: BorderRadius.circular(90),
            ),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(85),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          spreadRadius: 8,
                          blurRadius: 10,
                          offset: Offset(0, 0), // changes the position of the shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              spreadRadius: 8,
                              blurRadius: 10,
                              offset: Offset(0, 0), // changes the position of the shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38.0, vertical: 20),
                              child: CupertinoPicker(
                                scrollController: scrollController,
                                itemExtent: 40,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedCoin = coinOptions[index];
                                  });
                                },
                                children: coinOptions.map((coin) {
                                  return Text(
                                    coin,
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      color: Theme.of(context).textTheme.bodyLarge!.color,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox.square(dimension: 20.2),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () =>
                                        fetchCoinMarketData(selectedCoin),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 15,
                                      shadowColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    )
                                        : Text(
                                      'Show Coin Data',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            offset: Offset(.5, .5),
                                            blurRadius: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (coinData.isNotEmpty) ...[
                              Image.network(
                                coinData['image'],
                                height: 100,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Name: ${coinData['name']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                ),
                              ),
                              Text(
                                'Symbol: ${coinData['symbol']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                ),
                              ),
                              Text(
                                'Current Price: \$${coinData['current_price']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

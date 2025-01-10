import 'package:flutter/material.dart';
import 'cartItem.dart';
import 'item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping Cart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [
    Item(name: 'iPhone 15', price: 15000),
    Item(name: 'MacBook Pro', price: 250000),
    Item(name: 'iPad Pro', price: 10000),
    Item(name: 'Apple Watch Series 9', price: 4000),
    Item(name: 'AirPods Pro 2', price: 2500),
    Item(name: 'HomePod Mini', price: 1500),
    Item(name: 'Magic Keyboard', price: 3000),
    Item(name: 'Apple Pencil', price: 1000),
  ];


  int get total {
    return items.fold(0, (sum, item) => sum + (item.price * item.amount).toInt());
  }


  void clearCart() {
    setState(() {
      for (var item in items) {
        item.amount = 0;
      }
    });
  }

  void updateTotal() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [

            TextButton.icon(
              onPressed: clearCart,
              label: const Text('Clear Cart'),
              icon: const Icon(Icons.clear),
            ),

            for (Item item in items)
              CartItem(
                items: item,
                onQuantityChanged: updateTotal,
              ),
            Expanded(
              child: Container(),
            ),

            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '$total ฿',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

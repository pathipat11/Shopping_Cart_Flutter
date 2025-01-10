import 'package:flutter/material.dart';
import 'cartPage.dart';
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
    Item(name: 'iPhone 15', price: 15000, imageUrl: 'assets/images/iphone15.jpg'),
    Item(name: 'MacBook Pro', price: 250000, imageUrl: 'assets/images/mbp.jpg'),
    Item(name: 'iPad Pro', price: 10000, imageUrl: 'assets/images/ipadp.jpg'),
    Item(name: 'Apple Watch Series 9', price: 4000, imageUrl: 'assets/images/AppleWatch.jpg'),
    Item(name: 'AirPods Pro 2', price: 2500, imageUrl: 'assets/images/AirPods-Pro-2.jpg'),
  ];

  List<Item> cart = [];

  void addToCart(Item item) {
    setState(() {
      if (!cart.contains(item)) {
        cart.add(item);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to cart')),
    );
  }

  void clearCart() {
    setState(() {
      for (var item in cart) {
        item.amount = 0;
      }
      cart.clear();
    });
  }

  void updateItemQuantity(Item item, bool isIncrement) {
    setState(() {
      if (isIncrement) {
        item.amount++;
      } else if (item.amount > 0) {
        item.amount--;
      }
    });
  }

  // Calculate total dynamically based on the current cart items
  int get total => cart.fold(0, (sum, item) => sum + (item.price * item.amount).toInt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Custom background color
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.pink],
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () async {
              // Navigate to CartPage and get the updated cart and total
              final updatedCart = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cart: cart,
                    clearCart: clearCart,
                    updateItemQuantity: updateItemQuantity,
                  ),
                ),
              );
              // If the cart is updated, refresh the UI in MyHomePage
              if (updatedCart != null) {
                setState(() {
                  cart = updatedCart;
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(item.name),
              subtitle: Text('${item.price} ฿'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => updateItemQuantity(item, false),
                  ),
                  Text('${item.amount}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => updateItemQuantity(item, true),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () => addToCart(item),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

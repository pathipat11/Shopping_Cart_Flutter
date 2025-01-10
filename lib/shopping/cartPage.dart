import 'package:flutter/material.dart';
import 'item.dart';

class CartPage extends StatefulWidget {
  final List<Item> cart;
  final VoidCallback clearCart;
  final Function(Item, bool) updateItemQuantity;

  const CartPage({
    super.key,
    required this.cart,
    required this.clearCart,
    required this.updateItemQuantity,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Function to show the confirmation dialog for clearing the cart
  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart?'),
          content: const Text('Are you sure you want to clear all items from the cart?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.clearCart(); // Clear the cart
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context); // Pop CartPage and return to MyHomePage
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the confirmation dialog for checkout
  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout?'),
          content: const Text('Are you sure you want to proceed with checkout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and proceed with checkout
                widget.clearCart();
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkout complete!')),
                );
                Navigator.pop(context); // Navigate back to MyHomePage after checkout
              },
              child: const Text('Checkout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total dynamically in CartPage
    int total = widget.cart.fold(0, (sum, item) => sum + (item.price * item.amount).toInt());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Pop the current page and return to MyHomePage
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                if (item.amount == 0) return const SizedBox.shrink();
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.name),
                    subtitle: Text('${item.price} ฿ x ${item.amount}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            widget.updateItemQuantity(item, false);
                            setState(() {}); // Update UI after changing quantity
                          },
                        ),
                        Text('${item.amount}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            widget.updateItemQuantity(item, true);
                            setState(() {}); // Update UI after changing quantity
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 20)),
                    Text('$total ฿', style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _showClearCartDialog, // Show the confirmation dialog to clear cart
                      child: const Text('Clear Cart'),
                    ),
                    ElevatedButton(
                      onPressed: _showCheckoutDialog, // Show the checkout confirmation dialog
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

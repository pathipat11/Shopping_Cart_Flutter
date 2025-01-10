import 'package:flutter/material.dart';
import 'item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final Function onQuantityChanged;

  const CartItem({
    super.key,
    required this.items,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.items.price} ฿',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (widget.items.amount > 0) {
                    widget.items.amount--;
                    widget.onQuantityChanged();
                  }
                });
              },
            ),
            Text(
              '${widget.items.amount}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget.items.amount++;
                  widget.onQuantityChanged();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

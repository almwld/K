import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final double price;
  final bool isAvailable;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double scale = 1.0;

  void _down(_) => setState(() => scale = 0.96);
  void _up(_) => setState(() => scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: () => _up(null),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Hero(
                  tag: widget.id,
                  child: Image.network(
                    widget.image,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 140,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${widget.price.toStringAsFixed(0)} ر.ي",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.isAvailable ? "متوفر" : "غير متوفر",
                      style: TextStyle(
                        color: widget.isAvailable
                            ? Colors.green
                            : theme.colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


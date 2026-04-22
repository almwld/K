import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A3A54),
      highlightColor: const Color(0xFF3A4A64),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(
            width: double.infinity,
            height: 120,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                ShimmerLoading(width: 80, height: 14),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ShimmerLoading(width: 60, height: 12),
                    const Spacer(),
                    ShimmerLoading(width: 30, height: 30, borderRadius: BorderRadius.circular(20)),
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

class StoreCardShimmer extends StatelessWidget {
  const StoreCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ShimmerLoading(width: 50, height: 50, borderRadius: BorderRadius.circular(10)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(width: 120, height: 16),
                const SizedBox(height: 8),
                ShimmerLoading(width: 80, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

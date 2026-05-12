import 'package:flutter/material.dart';
import 'staggered_item.dart';

/// قائمة بعناصر متتابعة مع تأثير ظهور
class StaggeredAnimatedList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Duration staggerDelay;
  final Duration animationDuration;

  const StaggeredAnimatedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.staggerDelay = const Duration(milliseconds: 60),
    this.animationDuration = const Duration(milliseconds: 450),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: StaggeredItem(
            index: index,
            delay: staggerDelay,
            duration: animationDuration,
            child: itemBuilder(context, index),
          ),
        );
      },
    );
  }
}

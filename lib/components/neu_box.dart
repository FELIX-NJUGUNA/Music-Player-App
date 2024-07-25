import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          // dark shadow on bottom right
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4, 4)
          ),
          // lighter shadow on top left
          BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              offset: const Offset(-4, -4)
          ),
        ],

      ),
      child: child,
      padding: const EdgeInsets.all(12),
    );
  }
}

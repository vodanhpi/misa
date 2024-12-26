import 'package:flutter/material.dart';

class KptCardHeader extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onExpandedChanged;

  const KptCardHeader({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onExpandedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, bottom: 4.0),
          child: Row(
            children: [
              if (isExpanded) const Icon(Icons.error_rounded, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: IconButton(
            onPressed: onExpandedChanged,
            icon: Icon(isExpanded ? Icons.chevron_right : Icons.expand_more),
          ),
        ),
      ],
    );
  }
}

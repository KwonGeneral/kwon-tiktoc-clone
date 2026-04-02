import 'package:flutter/material.dart';

class PublishMenuItem extends StatelessWidget {
  const PublishMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

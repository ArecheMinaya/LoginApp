import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextStyle? textStyle;

  const IconText({
    super.key,
    required this.icon,
    required this.label,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // para que Wrap pueda partirlo
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        // Si el espacio se hace MUY chico, evitamos overflow con ellipsis
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 160),
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

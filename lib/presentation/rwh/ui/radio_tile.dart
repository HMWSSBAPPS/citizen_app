import 'package:flutter/material.dart';

class RadioTile extends StatelessWidget {
  const RadioTile({
    super.key,
    required this.selected,
    required this.onTap,
    required this.index,
    required this.title,
  });

  final String title;
  final int index;
  final int? selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      leading: Radio<int>(
        groupValue: selected,
        value: index,
        onChanged: (val) {
          onTap();
        },
      ),
    );
  }
}

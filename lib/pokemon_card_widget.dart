import 'package:flutter/material.dart';

class Pokemoncardwidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final VoidCallback ontap;

  const Pokemoncardwidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ontap.call(),
      child: Container(
        decoration: BoxDecoration(
          color: type == "Grass"
              ? Colors.green
              : type == "Fire"
              ? Colors.red
              : Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.network(imageUrl, fit: BoxFit.fill, width: double.infinity),
            Text(name),
            Text(type),
          ],
        ),
      ),
    );
  }
}

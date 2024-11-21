import 'package:flutter/material.dart';

// ProfileTile is a StatelessWidget that displays a tile with an icon, title, and data
class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xff5E9FCD)),
          title: Text(title),
          subtitle: Text(data),
        ),
      ),
    );
  }
}
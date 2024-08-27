import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {

  final String name, bio;

  const InfoCard({super.key, required this.name, required this.bio});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Icons.person, color: Colors.white,),
      ),
      title: Text(
        name, 
        style: const TextStyle(color: Colors.white),

      ),
      subtitle: Text(
        bio, 
        style: const TextStyle(color: Colors.white70)
      )
    );
  }
}
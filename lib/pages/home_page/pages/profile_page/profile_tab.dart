import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(width: 0, height: 0,),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                
              },
              child: const Icon(Icons.menu, color: Colors.white,)
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
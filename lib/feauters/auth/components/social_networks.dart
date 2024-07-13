import 'package:flutter/material.dart';

class SocialNetworks extends StatelessWidget {
  const SocialNetworks({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 400),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)
                ]
              ),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 32,
                child: Image.asset('assets/images/vk.png', width: 40,),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)
              ]
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 32,
              child: Image.asset('assets/images/google.png', width: 40,),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  final double? size;
  const MainLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size!*4,
      height: size!*2,
      child: Center(
        child: Row(
          children: [
            Text("Crowd",
              style:TextStyle(
                fontFamily: 'HookedUp',
                fontSize: size!*1.12,
                color: Colors.white.withOpacity(0.8),
              )
            ),
            Text("SOUND",
              style: TextStyle(
                fontFamily: 'LibreBarcode',
                fontSize: size!,
                color: Colors.white.withOpacity(0.8),
                fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
    );
  }
}
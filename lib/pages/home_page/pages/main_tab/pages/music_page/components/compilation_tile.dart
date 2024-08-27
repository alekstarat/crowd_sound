import 'package:flutter/material.dart';

class CompilationTile extends StatelessWidget {

  final Color categoryColor;
  final String name, image;

  const CompilationTile({super.key, required this.categoryColor, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.45,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColorDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: const Offset(0.0, 5.0),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image, fit: BoxFit.cover,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 75,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: categoryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: const Offset(0.0, 5.0)
                  )
                ],
              ),
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'PoiretOne'
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
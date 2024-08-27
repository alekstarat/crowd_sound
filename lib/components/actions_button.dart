import 'package:flutter/material.dart';

class ActionsButton extends StatefulWidget {
  const ActionsButton({super.key});

  @override
  State<ActionsButton> createState() => _ActionsButtonState();
}

class _ActionsButtonState extends State<ActionsButton> {

  bool isOpened = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.25,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          AnimatedPositionedDirectional(
            duration: const Duration(milliseconds: 100),
            top: isOpened ? 45 : 0,
            child: IgnorePointer(
              ignoring: !isOpened,
              child: AnimatedOpacity(
                opacity: isOpened? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1)
                  ),
                  child: Center(
                    child: Icon(Icons.message_outlined, color: Colors.white.withOpacity(0.5), size: 15),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositionedDirectional(
            duration: const Duration(milliseconds: 100),
            end: isOpened ? 45 : 0,
            child: IgnorePointer(
              ignoring: !isOpened,
              child: AnimatedOpacity(
                opacity: isOpened? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1)
                  ),
                  child: Center(
                    child: Icon(Icons.person_add, color: Colors.white.withOpacity(0.5), size: 15),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositionedDirectional(
            duration: const Duration(milliseconds: 100),
            end: isOpened ? 35 : 0,
            top: isOpened ? 35 : 0,
            child: IgnorePointer(
              ignoring: !isOpened,
              child: AnimatedOpacity(
                opacity: isOpened? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: GestureDetector(
                  onTap: () {
                    if (isOpened) {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    }
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1)
                    ),
                    child: Center(
                      child: Icon(isLiked? Icons.favorite : Icons.favorite_outline, color: isLiked? Colors.red.withOpacity(0.5) : Colors.white.withOpacity(0.5), size: 15),
                    ), 
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onLongPress: () {
              setState(() {
                isOpened = true;
              });
            },
            onTap: () {
              if (isOpened) {
                setState(() {
                  isOpened = false;
                });
              } else {
                if (!isOpened) {
                  setState(() {
                    isLiked = !isLiked;
                  });
                }
              }
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1)
              ),
              child: Center(
                child: isOpened ? Icon(Icons.menu, size: 15, color: Colors.white.withOpacity(0.5),) : Icon(isLiked ? Icons.favorite : Icons.favorite_outline, size: 15, color: isLiked ? Colors.red.withOpacity(0.5) : Colors.white.withOpacity(0.5))
                //child: Icon(isOpened ? Icons.menu : (isLiked ? Icons.favorite : Icons.favorite_outline), color: Colors.white.withOpacity(0.5), size: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
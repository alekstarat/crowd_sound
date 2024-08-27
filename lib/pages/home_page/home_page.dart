// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:crowd_sound/feauters/utils/rive_utils.dart';
import 'package:crowd_sound/models/menu.dart';
import 'package:crowd_sound/pages/home_page/components/btm_nav_item.dart';
import 'package:crowd_sound/pages/home_page/components/category_selector/category_selector.dart';
import 'package:crowd_sound/pages/home_page/pages/main_tab/main_tab.dart';
import 'package:crowd_sound/pages/home_page/pages/map_page/map_page.dart';
import 'package:crowd_sound/pages/home_page/pages/profile_page/profile_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {

  late final TabController _tabController;
  late final TabController _categoryController;

  bool isSideBarOpen = false;

  Menu selectedBottomNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;
  
  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottomNav != menu) {
      setState(() {
        selectedBottomNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _categoryController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200)
    )..addListener(
      () {
        setState(() {});
      }
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleSideBar() {
    if (selectedBottomNav != bottomNavItems[1]) {
      //isMenuOpenInput.value = !isMenuOpenInput.value;
                
      if (_animationController.value == 0) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }

      setState(() {
        isSideBarOpen = !isSideBarOpen;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    final CategorySelector categorySelector = CategorySelector(
      categoryController: _categoryController,
    );

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          categorySelector,
          AnimatedPositioned( 
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -288,
            top: 0,
            //child: const SideBar()
            child: const SizedBox(
              width: 0,
              height: 1,
            )
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                1 * animation.value - 30 * (animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scalAnimation.value,
                child: ClipRRect(
                  borderRadius: isSideBarOpen ? const BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)) : BorderRadius.zero,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        transform: const GradientRotation(8*pi/3),
                          colors: [Theme.of(context).primaryColorDark, Theme.of(context).secondaryHeaderColor]
                      )
                    ),
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        if (!isSideBarOpen && selectedBottomNav == bottomNavItems[0]) {
                          if (details.delta.dx > 0) {
                            toggleSideBar();
                          }
                        }
                      },
                      onTap: () {
                        if (isSideBarOpen) {
                          toggleSideBar();
                        }
                      },
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children:  [
                            IgnorePointer(
                              ignoring: isSideBarOpen,
                              child: MainTab(tabController: _categoryController)
                            ),
                            MapPage(),
                            const SizedBox(),
                            ProfileTab(),
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ),
          ),
          
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: selectedBottomNav != bottomNavItems[1] ? Theme.of(context).primaryColorDark.withOpacity(0.8) : Theme.of(context).primaryColorDark.withOpacity(0.9),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: selectedBottomNav != bottomNavItems[1] ? Theme.of(context).primaryColorDark.withOpacity(0.3) : Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    bottomNavItems.length, 
                    (index) {
                      Menu navBar = bottomNavItems[index];
                      return BtmNavItems(
                        navBar: navBar, 
                        selectedNav: selectedBottomNav, 
                        press: () {
                          RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                          updateSelectedBtmNav(navBar);
                          _tabController.animateTo(index);
                        }, 
                        riveOnInit: (artboard) {
                          navBar.rive.status = RiveUtils.getRiveInput(artboard, 
                            stateMachineName: navBar.rive.stateMachineName);
                        },
                      );
                    }
                  )
                ],
              )
            ),
          ),
        )
      ),
    );
  }
}
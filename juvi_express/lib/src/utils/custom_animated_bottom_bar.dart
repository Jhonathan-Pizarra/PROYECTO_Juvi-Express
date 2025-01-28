import 'package:flutter/material.dart';

class CustomAnimatedBottomBar extends StatelessWidget {
  CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.iconSize = 24,
    this.containerHeight = 60,
    this.animationDuration = const Duration(milliseconds: 300),
    this.itemCornerRadius = 30,
    this.items = const [],
    required this.onItemSelected,
  })  : assert(items.length >= 2 && items.length <= 6),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final double containerHeight;
  final double itemCornerRadius;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber, // Fondo completamente ámbar
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: containerHeight,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              var index = items.indexOf(item);
              return Expanded(
                child: GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: AnimatedContainer(
                    duration: animationDuration,
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? Colors.amber.shade300 // Fondo ámbar claro para el ítem activo
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(itemCornerRadius),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconTheme(
                          data: IconThemeData(
                            size: selectedIndex == index
                                ? iconSize + 6
                                : iconSize,
                            color: selectedIndex == index
                                ? Colors.white // Ícono blanco para ítem activo
                                : item.inactiveColor ?? Colors.black,
                          ),
                          child: item.icon,
                        ),
                        if (selectedIndex == index)
                          SizedBox(height: 4),
                        if (selectedIndex == index)
                          Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.white, // Texto blanco para ítem activo
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.white, // Cambiado para contraste
    this.inactiveColor,
  });

  final Widget icon;
  final String title;
  final Color activeColor;
  final Color? inactiveColor;
}

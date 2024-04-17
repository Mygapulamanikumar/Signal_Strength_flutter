import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> routeNames;
  final void Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.routeNames,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey[600],
      unselectedItemColor: Colors.black,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: List.generate(routeNames.length, (index) {
        return BottomNavigationBarItem(
          backgroundColor: Colors.grey[900],
          icon: _buildIconForIndex(index),
          label: _buildLabelForIndex(index),
        );
      }),
    );
  }

  Icon _buildIconForIndex(int index) {
    switch (index) {
      case 0:
        return const Icon(Icons.live_tv_outlined);
      case 1:
        return const Icon(Icons.list);
      case 2:
        return const Icon(Icons.insert_chart);
      case 3:
        return const Icon(Icons.map);
      default:
        return const Icon(Icons.error);
    }
  }

  String _buildLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Live';
      case 1:
        return 'Logs';
      case 2:
        return 'Graphs';
      case 3:
        return 'Maps';
      default:
        return 'Error';
    }
  }
}

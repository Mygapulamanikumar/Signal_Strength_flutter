import 'package:flutter/material.dart';
import 'UIScreen/phInfo.dart';
class Appbar extends StatefulWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => AppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppbarState extends State<Appbar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Net Monster', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[900],
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'finish') {
              // Handle the 'Finish' action
            } else if (value == 'Phone') {
              // Navigate to the 'Phone Info' screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const phInfo()),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Finish',
              child: Text('Finish', style: TextStyle(color: Colors.black)),
            ),
            const PopupMenuItem<String>(
              value: 'Phone',
              child: Text('Phone Info', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}

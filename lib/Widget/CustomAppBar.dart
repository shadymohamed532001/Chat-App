import 'package:flutter/material.dart';
import 'package:scholor_chat/constans.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String Status;
  const ChatAppBar({Key? key, required this.name, required this.Status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/shix.png'),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
               Text(
                Status,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined,size: 22,),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final String profileUrl;
  final void Function()? onTap;
  final String name;

  const ChatListTile({
    super.key,
    required this.profileUrl,
    required this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    print(name);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(profileUrl),
              onBackgroundImageError: (_, __) => const Icon(
                Icons.person_outline_sharp,
                color: Colors.grey,
                size: 40,
              ),
              child:
                  Container(), // To avoid a blank avatar if the image fails to load
            ),
            const SizedBox(width: 10.0),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

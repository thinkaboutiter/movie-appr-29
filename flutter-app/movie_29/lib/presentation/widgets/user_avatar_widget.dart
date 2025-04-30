import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final double size;

  const UserAvatarWidget({
    super.key,
    this.avatarUrl,
    required this.name,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return avatarUrl != null && avatarUrl!.isNotEmpty
        ? Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(avatarUrl!),
                fit: BoxFit.cover,
              ),
            ),
          )
        : CircleAvatar(
            radius: size / 2,
            backgroundColor: Colors.blue,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.4,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

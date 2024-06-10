import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';

class AnnouncementManagementTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback onEdit ;
  final VoidCallback onDelete;
  final VoidCallback onOpen;

  

  const AnnouncementManagementTile({super.key, 
    required this.imageUrl,
    required this.name,
    required this.onEdit,
    required this.onDelete,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
            color: CustomColors.errorColor,
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: onOpen,
          ),
        ],
      ),
    );
  }
}
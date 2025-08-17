import 'package:flutter/material.dart';
import 'package:snt_app/Models/user_model.dart';

class DepartmentMemberCard extends StatelessWidget {
  final UserModel user;

  const DepartmentMemberCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: user.role.toLowerCase() == "manager"
              ? Colors.purple
              : user.role.toLowerCase() == "co-manager"
                  ? Colors.orange
                  : Colors.grey.shade300,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: user.pfp != null && user.pfp!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(user.pfp!),
                radius: 24,
              )
            : CircleAvatar(
                radius: 24,
                backgroundColor: Colors.primaries[user.username.hashCode % Colors.primaries.length],
                child: Text(
                  user.username[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
        title: Text(
          user.username,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          user.role,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ),
    );
  }
}

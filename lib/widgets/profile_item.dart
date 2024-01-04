import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress,
    this.widgetTrailing,
  });
  final VoidCallback onPress;
  final String title;
  final IconData icon;
  final Widget? widgetTrailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      trailing: widgetTrailing ??
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';

class LessonTile extends StatelessWidget {
  final String title;
  final String duration;
  final bool isCompleted;
  final bool isLocked;
  final bool isUnlocked;
  final bool isActive;
  final VoidCallback onTap;

  const LessonTile({
    super.key,
    required this.title,
    required this.duration,
    required this.isCompleted,
    required this.isLocked,
    required this.isUnlocked,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tileColor = isActive
        ? theme.colorScheme.primary.withOpacity(0.08)
        : null;

    return ListTile(
      tileColor: tileColor,
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: isCompleted
            ? theme.colorScheme.primary
            : isLocked
                ? theme.colorScheme.secondary.withOpacity(0.1)
                : isActive
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : theme.colorScheme.secondary.withOpacity(0.2),
        child: Icon(
          isCompleted
              ? Icons.check
              : isLocked
                  ? Icons.lock
                  : Icons.play_arrow,
          color: isCompleted
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.secondary,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isLocked
              ? theme.colorScheme.secondary
              : isActive
                  ? theme.colorScheme.primary
                  : Colors.black,
        ),
      ),
      subtitle: Text(
        duration,
        style: theme.textTheme.bodySmall?.copyWith(
          color: isLocked ? theme.colorScheme.secondary : null,
        ),
      ),
      trailing: isActive
          ? Icon(Icons.play_circle_fill,
              color: theme.colorScheme.primary)
          : const Icon(Icons.chevron_right),
    );
  }
}


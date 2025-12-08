import 'package:e_learning_application/core/utils/app_dialogs.dart';
import 'package:e_learning_application/routes/app_routes.dart';
import 'package:e_learning_application/views/profile/widgets/profile_option_card.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOptionCard(
          title: 'Edit Profile',
          subtitle: 'Update your Personal Information',
          icon: Icons.edit_outlined,
          onTap: () {},
        ),
        ProfileOptionCard(
          title: 'Notifications',
          subtitle: 'Manage your Notifications',
          icon: Icons.notifications_outlined,
          onTap: () {},
        ),
        ProfileOptionCard(
          title: 'Settings',
          subtitle: 'App preferences and more',
          icon: Icons.settings_outlined,
          onTap: () {},
        ),
        ProfileOptionCard(
          title: 'Help & Support',
          subtitle: 'Get Help or Connect Support',
          icon: Icons.help_outline,
          onTap: () {},
        ),
        ProfileOptionCard(
          title: 'Logout',
          subtitle: 'Sign Out of your account',
          icon: Icons.logout,
          onTap: () async {
            final confirm = await AppDialogs.showLogoutDialog();
            if (confirm == true) {
              // navigate to login page
              Get.offAllNamed(AppRoutes.login);
            }
          },
          isDestructive: true,
        ),
      ],
    );
  }
}

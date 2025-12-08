import 'package:e_learning_application/core/theme/app_colors.dart';
import 'package:e_learning_application/views/profile/widgets/profile_app_bar.dart';
import 'package:e_learning_application/views/profile/widgets/profile_options.dart';
import 'package:e_learning_application/views/profile/widgets/profile_state_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          ProfileAppBar(
            initials: 'AR',
            fullName: 'Arya Dwi Pangga',
            email: 'arya@gmail.com',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfileStateCard(),
                  SizedBox(height: 24),
                  ProfileOptions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

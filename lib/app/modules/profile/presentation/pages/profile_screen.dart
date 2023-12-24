import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../../../config/routers/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/app_prefs.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_photo_and_username_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.isScreenBottombar = false,
  });

  final bool isScreenBottombar;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(const ProfileUserEvent());
    return Container(
      margin: (widget.isScreenBottombar)
          ? const EdgeInsets.only(right: 12, top: kToolbarHeight, left: 12)
          : const EdgeInsets.only(top: kToolbarHeight),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: NestedScrollView(
          physics: (widget.isScreenBottombar)
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, _) {
            return [
              if (widget.isScreenBottombar)
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 0,
                  flexibleSpace: Container(
                    height: 48,
                    width: double.infinity,
                    color: AppColors.primary,
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "PROFILE".asSubtitleBig(
                            fontWeight: FontWeight.w400, color: Colors.white),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 24.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              else
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 0,
                  flexibleSpace: Container(
                    height: 48,
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "PROFILE".asSubtitleBig(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 24.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ];
          },
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              switch (state) {
                case ProfileLoadingState():
                  return const SizedBox.shrink();
                case ProfileFailureState():
                  return Text(state.failure.toString());
                case ProfileErrorState():
                  return Text(state.error.toString());
                case ProfileSuccessState():
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ProfilePhotoAndUsernameWidget(
                          username: state.user?.displayName,
                          userEmail: state.user?.email,
                          userPhoneNumber: state.user?.phoneNumber,
                          onTapEdit: () async {
                            var result = await context.pushNamed(
                              AppRoutes.profileUpdate.name,
                              extra: {
                                'user_email': state.user?.email,
                                'username': state.user?.displayName,
                                'user_phone_number': state.user?.phoneNumber,
                              },
                            );

                            if (result != null) {
                              result as bool;
                              if (result) {
                                bloc.add(const ProfileUserEvent());
                              }
                            }
                          },
                        ),
                      ),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                        thickness: 0.5,
                        color: AppColors.primary,
                      ),
                      _buildDefaultTile(
                        icon: Icons.lock_outline,
                        title: 'Security',
                        subtitle: 'Keep your account secure',
                      ),
                      _buildDefaultTile(
                        icon: Icons.verified_outlined,
                        title: 'Verify',
                        subtitle: 'Verify your email',
                      ),
                      _buildDefaultTile(
                        icon: Icons.help_outline,
                        title: 'Help',
                        subtitle: 'Help center, contact us',
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 16, right: 12),
                        leading: const Icon(
                          Icons.info_outline,
                          size: 20.0,
                          color: AppColors.primary,
                        ),
                        dense: true,
                        minVerticalPadding: 1,
                        horizontalTitleGap: 12,
                        title: 'About'.asSubtitleNormal(),
                        subtitle: 'About us'.asSubtitleSmall(),
                        trailing: Icon(
                          Icons.arrow_right,
                          size: 24.0,
                          color: Colors.grey[400],
                        ),
                      ),
                      _buildDefaultTile(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () async {
                          await AppPrefs.removeEmail();
                          await FirebaseAuth.instance.signOut();
                          if (mounted) {
                            context.goNamed(AppRoutes.authentication.name);
                          }
                        },
                      ),
                      32.height,
                      Center(
                        child: 'v1.0.0'.asSubtitleSmall(color: Colors.grey),
                      ),
                    ],
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  ListTile _buildDefaultTile(
      {IconData? icon,
      String? title,
      String? subtitle,
      void Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 16, right: 12),
      leading: Icon(
        icon,
        size: 20.0,
        color: AppColors.primary,
      ),
      dense: true,
      minVerticalPadding: 1,
      horizontalTitleGap: 12,
      title: '$title'.asSubtitleNormal(),
      subtitle: subtitle?.asSubtitleSmall(),
      trailing: Icon(
        Icons.arrow_right,
        size: 24.0,
        color: Colors.grey[400],
      ),
    );
  }
}

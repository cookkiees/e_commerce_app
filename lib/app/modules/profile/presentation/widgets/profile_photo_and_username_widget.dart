import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';

class ProfilePhotoAndUsernameWidget extends StatelessWidget {
  const ProfilePhotoAndUsernameWidget({
    super.key,
    this.username,
    this.userEmail,
    this.userPhoneNumber,
    this.onTapEdit,
  });

  final void Function()? onTapEdit;
  final String? username;
  final String? userPhoneNumber;
  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/user_photo.jpg'),
              ),
            ),
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              '$username'.asSubtitleBig(fontWeight: FontWeight.w400),
              2.height,
              '$userEmail'.asSubtitleSmall(
                color: Colors.grey,
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTapEdit,
                  child: const Icon(
                    Icons.edit,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

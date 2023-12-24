import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/config/themes/app_colors.dart';
import 'package:e_commerce_app/app/core/helpers/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> mainOpenLink(String url) async {
  if (await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class NotificationsViews extends StatefulWidget {
  const NotificationsViews({super.key});

  @override
  State<NotificationsViews> createState() => _NotificationsViewsState();
}

class _NotificationsViewsState extends State<NotificationsViews> {
  String userEmail = '';

  @override
  void initState() {
    getUserEmail();
    super.initState();
  }

  void getUserEmail() async {
    userEmail = await AppPrefs.getEmail();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          16.height,
          ListTile(
            dense: true,
            isThreeLine: true,
            leading: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user_photo.jpg"),
            ),
            title:
                'Hi, $userEmail'.asSubtitleNormal(fontWeight: FontWeight.w400),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Want to create your own application?. you can message me!.'
                    .asSubtitleNormal(),
                4.height,
                Row(
                  children: [
                    InkWell(
                      onTap: () async =>
                          await mainOpenLink(AppLink.instagram.url),
                      child: 'Instagram, '
                          .asSubtitleNormal(color: AppColors.primary),
                    ),
                    InkWell(
                      onTap: () async =>
                          await mainOpenLink(AppLink.linkedin.url),
                      child: 'Linkedin.'
                          .asSubtitleNormal(color: AppColors.primary),
                    ),
                  ],
                ),
                4.height,
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AppLink {
  instagram,
  linkedin,
  github,
  resume,
}

extension AppPortfolioExtension on AppLink {
  String get url {
    switch (this) {
      case AppLink.instagram:
        return 'https://www.instagram.com/craackers._/';
      case AppLink.linkedin:
        return 'https://www.linkedin.com/in/aldojohanda/';
      case AppLink.github:
        return 'https://github.com/cookkiees';
      case AppLink.resume:
        return 'https://drive.google.com/file/d/1Gf7_J1VnPcXukgg_TJWUv3ZwLHvA0Fu9/view?usp=sharing';
      default:
        return '';
    }
  }
}

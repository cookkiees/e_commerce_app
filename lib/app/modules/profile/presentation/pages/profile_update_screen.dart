import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../../../components/app_elevated_button_widget.dart';
import '../../../../components/app_text_form_field_widget.dart';
import '../bloc/profile_bloc.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen(
      {super.key, this.userEmail, this.username, this.userPhoneNumber});

  final String? userEmail;
  final String? username;
  final String? userPhoneNumber;

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.clear,
              color: Colors.grey,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Edit your username and phone number?'.asTitleSmall(
                  fontWeight: FontWeight.w400,
                ),
                6.height,
                'Put your username and phone number, You can change this at any time.'
                    .asSubtitleSmall(),
                24.height,
                'Username'.asSubtitleNormal(
                  fontWeight: FontWeight.w400,
                ),
                8.height,
                SizedBox(
                  height: 44,
                  child: AppTextFormFieldWidget(
                    controller: usernameController,
                    hintText: widget.username,
                  ),
                ),
                12.height,
                'Phone number'.asSubtitleNormal(
                  fontWeight: FontWeight.w400,
                ),
                8.height,
                SizedBox(
                  height: 44,
                  child: AppTextFormFieldWidget(
                    controller: phoneNumberController,
                    hintText:
                        widget.userPhoneNumber ?? 'Enter your phone number',
                  ),
                ),
                44.height,
                BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    switch (state) {
                      case ProfileSuccessState():
                        context.pop(true);
                        break;
                      default:
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: AppElevatedButtonWidget(
                        onPressed: () async {
                          BlocProvider.of<ProfileBloc>(context).add(
                            ProfileUpdateUserEvent(
                              username: usernameController.text,
                              phoneNumber: phoneNumberController.text,
                            ),
                          );
                        },
                        child: state is ProfileLoadingState
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : 'Save'.asLabelButton(color: Colors.white),
                      ),
                    );
                  },
                ),
                24.height,
              ],
            ),
          ),
        ));
  }
}

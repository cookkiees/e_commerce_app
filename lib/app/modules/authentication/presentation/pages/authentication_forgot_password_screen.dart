import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/layout/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../components/app_elevated_button_widget.dart';
import '../../../../components/app_text_form_field_widget.dart';

class AuthenticationForgotPasswordScreen extends StatelessWidget {
  const AuthenticationForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: context.isPhone
            ? AppBar(
                leading: InkWell(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24.0,
                    color: Colors.grey[400],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (context.isPhone) {
            return _buildWidget();
          } else {
            return Row(
              children: [
                Flexible(child: Container(color: Colors.grey[100])),
                if (!context.isTablet) 24.width,
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 16),
                        child: InkWell(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 500,
                        child: _buildWidget(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Forgot Password?'.asTitleNormal(
              fontWeight: FontWeight.w600,
            ),
            'Enter your email address, and we will send password reset instructions to your email.'
                .asSubtitleNormal(),
            32.height,
            'Email'.asSubtitleNormal(
              fontWeight: FontWeight.w400,
            ),
            4.height,
            const SizedBox(
              height: 44,
              child: AppTextFormFieldWidget(
                hintText: 'Enter your email',
              ),
            ),
            24.height,
            SizedBox(
              height: 44,
              child: AppElevatedButtonWidget(
                onPressed: () {},
                child: "Reset Password".asLabelButton(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

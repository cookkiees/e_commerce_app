import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/common/utils/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import '../../../../common/utils/app_loading_button.dart';
import '../../../../components/app_elevated_button_widget.dart';
import '../../../../components/app_text_form_field_widget.dart';
import '../../../../config/routers/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../bloc/auth_bloc.dart';

class AuthenticationLoginWidget extends StatefulWidget {
  const AuthenticationLoginWidget({super.key, this.onEnter});
  final VoidCallback? onEnter;

  @override
  State<AuthenticationLoginWidget> createState() =>
      _AuthenticationLoginWidgetState();
}

class _AuthenticationLoginWidgetState extends State<AuthenticationLoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: 32, left: 16, right: 16, bottom: context.viewInsetsBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Sign In to E-Commerce".asTitleBig(),
          50.height,
          SizedBox(
            height: 44,
            width: double.infinity,
            child: AppElevatedButtonIconWidget(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                side: const BorderSide(color: AppColors.primary),
              ),
              onPressed: () {},
              label: 'Sign in with Google'.asLabelButton(),
              icon: SvgPicture.asset(
                'assets/icons/google.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
          32.height,
          Row(
            children: [
              const Flexible(child: Divider(endIndent: 16)),
              'or sign in with email'.asSubtitleNormal(),
              const Flexible(child: Divider(indent: 16)),
            ],
          ),
          32.height,
          _buildEmailField(),
          12.height,
          _buildPasswordField(),
          32.height,
          _buildSignUpButton(),
          12.height,
          Center(
            child: InkWell(
              onTap: widget.onEnter,
              child: _buildDontHaveAccount(),
            ),
          ),
        ],
      ),
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buildSignUpButton() {
    var bloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.appDialogText(
            title: 'Sign In Succesfull!',
            message: "Thanks to join us ${state.user?.email}",
          );
          context.goNamed(AppRoutes.main.name);
        }
        if (state is AuthFailureState) {
          context.appDialogText(
            title: 'Sign In failure!',
            message: "${state.failure}!",
          );
        }
        if (state is AuthErrorState) {
          context.appDialogText(
            title: 'Sign In error!',
            message: "${state.error}!",
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 44,
          child: AppElevatedButtonWidget(
            onPressed: state is AuthInitialState ||
                    state is AuthFailureState ||
                    state is AuthErrorState
                ? () async {
                    bloc.add(AuthSignInEvent(
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                  }
                : () {},
            child: state is AuthLoadingState
                ? buildAppLoadingButton()
                : 'Sign In'.asLabelButton(color: Colors.white),
          ),
        );
      },
    );
  }

  Text _buildDontHaveAccount() {
    return const Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 11,
        ),
        text: 'Don\'t have an account ',
        children: [
          TextSpan(
            text: 'Sign up.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Password'.asSubtitleNormal(
          fontWeight: FontWeight.w400,
        ),
        8.height,
        SizedBox(
          height: 44,
          child: AppTextFormFieldWidget(
            obscureText: isObscureText,
            hintText: 'Enter your password',
            controller: passwordController,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () => setState(() => isObscureText = !isObscureText),
                child: Icon(
                  isObscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.0,
                  color: AppColors.primary,
                ),
              ),
            ),
            onChanged: (query) {},
          ),
        ),
        4.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => context.pushNamed(AppRoutes.forgotPassword.name),
              child: 'Forgot password ?'.asSubtitleSmall(
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Email'.asSubtitleNormal(
          fontWeight: FontWeight.w400,
        ),
        8.height,
        SizedBox(
          height: 44,
          child: AppTextFormFieldWidget(
            controller: emailController,
            hintText: 'Enter your email',
          ),
        ),
      ],
    );
  }
}

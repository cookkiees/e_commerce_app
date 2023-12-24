import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/common/utils/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';

import '../../../../common/extensions/app_datetime_extension.dart';
import '../../../../components/app_elevated_button_widget.dart';
import '../../../../components/app_text_form_field_widget.dart';
import '../../../../config/routers/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/app_validator.dart';
import '../bloc/auth_bloc.dart';

class AuthenticationRegisterWidget extends StatefulWidget {
  const AuthenticationRegisterWidget({super.key, this.onEnter});

  final VoidCallback? onEnter;

  @override
  State<AuthenticationRegisterWidget> createState() =>
      _AuthenticationRegisterWidgetState();
}

class _AuthenticationRegisterWidgetState
    extends State<AuthenticationRegisterWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  bool isLengthValid = false;
  bool isUpperCase = false;
  bool hasNumber = false;
  String errorEmailMessage = '';
  bool isObscureText = true;
  bool isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: 16, left: 16, right: 16, bottom: context.viewInsetsBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Sign up to E-Commerce".asTitleBig(
            color: AppColors.primary,
          ),
          50.height,
          _buildEmailField(),
          12.height,
          _buildFirstAndLastName(),
          12.height,
          _buildPasswordField(),
          12.height,
          _buildDateOfBirthfield(),
          24.height,
          _buildPrivacyPolicy(),
          32.height,
          _buildSignUpButton(),
          12.height,
          Center(
            child: InkWell(
              onTap: widget.onEnter,
              child: _buildAlreadyHaveAccount(),
            ),
          ),
          32.height,
          Row(
            children: [
              const Flexible(child: Divider(endIndent: 16)),
              'or sign up with email'.asSubtitleNormal(),
              const Flexible(child: Divider(indent: 16)),
            ],
          ),
          32.height,
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
              label: 'Sign up with Google'.asLabelButton(),
              icon: SvgPicture.asset(
                'assets/icons/google.svg',
                height: 24,
                width: 24,
              ),
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
            title: 'Sign Up Succesfull!',
            message: "Thanks to join us ${state.user?.email}",
          );
          context.goNamed(AppRoutes.main.name);
        }
        if (state is AuthFailureState) {
          context.appDialogText(
            title: 'Create account failure!',
            message: "${state.failure}!",
          );
        }
        if (state is AuthErrorState) {
          context.appDialogText(
            title: 'Create account error!',
            message: "${state.failure}!",
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 44,
          width: double.infinity,
          child: AppElevatedButtonWidget(
            onPressed: state is AuthInitialState ||
                    state is AuthFailureState ||
                    state is AuthErrorState
                ? () {
                    bloc.add(AuthSignUpEvent(
                      email: emailController.text,
                      password: passwordController.text,
                      firstname: firstnameController.text,
                      lastname: lastnameController.text,
                      birthday: birthdayController.text,
                    ));
                  }
                : () {},
            child: state is AuthLoadingState
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : 'Create Account'.asLabelButton(color: Colors.white),
          ),
        );
      },
    );
  }

  Text _buildAlreadyHaveAccount() {
    return const Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
        text: 'Already have an account ',
        children: [
          TextSpan(
            text: 'Sign in.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Text _buildPrivacyPolicy() {
    return const Text.rich(
      TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
        text: 'By continuing, I agree to App ',
        children: [
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
              color: AppColors.primary,
            ),
          ),
          TextSpan(text: ' and\n'),
          TextSpan(
            text: 'Terms of use.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateOfBirthfield() {
    DateTime currentDate = DateTime.now();
    DateTime initialDate = currentDate.subtract(const Duration(days: 365 * 18));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Date of Birth'.asSubtitleNormal(
          fontWeight: FontWeight.w400,
        ),
        8.height,
        SizedBox(
          height: 44,
          child: AppTextFormFieldWidget(
            readOnly: true,
            controller: birthdayController,
            hintText: 'Enter your date of birthday',
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1900),
                    lastDate: currentDate,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dialogBackgroundColor: Colors.white,
                          colorScheme: const ColorScheme.light(
                            primary: AppColors.primary,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (selectedDate != null && selectedDate != initialDate) {
                    final formattedDate = selectedDate.formatWithEnum(
                        DateTimeFormat.defaultFormat, 'en_US');
                    setState(() {
                      birthdayController.text = formattedDate;
                    });
                  }
                },
                child: const Icon(
                  Icons.calendar_month_outlined,
                  size: 20.0,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    isLengthValid = passwordController.text.length >= 8;
    isUpperCase = passwordController.text.contains(RegExp(r'[A-Z]'));
    hasNumber = passwordController.text.contains(RegExp(r'[0-9]'));
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
            onChanged: (query) {
              setState(() {
                isLengthValid =
                    query.validate(type: ValidationType.passwordLength).isEmpty;
                isUpperCase = query
                    .validate(type: ValidationType.passwordUppercase)
                    .isEmpty;
                hasNumber = query
                    .validate(type: ValidationType.passwordhasNumber)
                    .isEmpty;
              });
            },
          ),
        ),
        4.height,
        Row(
          children: [
            Icon(
              isLengthValid ? Icons.check : Icons.clear,
              size: 14,
              color: isLengthValid ? Colors.green : Colors.grey,
            ),
            ' Minimum of 8 characters.'.asSubtitleSmall(
              color: isLengthValid ? Colors.green : null,
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              isUpperCase && hasNumber ? Icons.check : Icons.clear,
              size: 14,
              color: isUpperCase && hasNumber ? Colors.green : Colors.grey,
            ),
            ' Uppercase, lowecase, and one number.'.asSubtitleSmall(
              color: isUpperCase && hasNumber ? Colors.green : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFirstAndLastName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'First name'.asSubtitleNormal(
                fontWeight: FontWeight.w400,
              ),
              8.height,
              Flexible(
                child: SizedBox(
                  height: 44,
                  child: AppTextFormFieldWidget(
                    controller: firstnameController,
                    hintText: 'Enter your firstname',
                  ),
                ),
              ),
            ],
          ),
        ),
        16.width,
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Last name'.asSubtitleNormal(
                fontWeight: FontWeight.w400,
              ),
              8.height,
              Flexible(
                child: SizedBox(
                  height: 44,
                  child: AppTextFormFieldWidget(
                    controller: lastnameController,
                    hintText: 'Enter your lastname',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    errorEmailMessage = emailController.text.validate(
      type: ValidationType.email,
      isRequired: true,
    );

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
            onChanged: (query) {
              emailController.text.validate(
                type: ValidationType.email,
                isRequired: true,
              );
              setState(() {});
            },
          ),
        ),
        4.height,
        if (errorEmailMessage.isNotEmpty)
          Row(
            children: [
              const Icon(
                Icons.email,
                color: Colors.red,
                size: 14,
              ),
              4.width,
              errorEmailMessage.asSubtitleSmall(color: Colors.red),
            ],
          )
        else
          Row(
            children: [
              const Icon(
                Icons.email,
                color: Colors.orange,
                size: 14,
              ),
              4.width,
              'Use an active email to create new account!'.asSubtitleSmall(
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
      ],
    );
  }
}

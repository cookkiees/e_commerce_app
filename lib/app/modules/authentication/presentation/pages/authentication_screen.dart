import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:flutter/material.dart';

import '../../../../layout/responsive_layout.dart';
import '../widgets/authentication_login_widget.dart';
import '../widgets/authentication_register_widget.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool changeViews = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: context.isPhone
                ? AppBar(
                    leading: !changeViews
                        ? InkWell(
                            onTap: () => setState(() => changeViews = true),
                            child: Icon(
                              Icons.arrow_back,
                              size: 24.0,
                              color: Colors.grey[400],
                            ),
                          )
                        : null)
                : const SizedBox.shrink(),
          ),
          body: !context.isPhone
              ? Row(
                  children: [
                    Flexible(child: Container(color: Colors.grey[100])),
                    if (!context.isTablet) 24.width,
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: 500,
                        child: buildAuthentication(
                          changeViews: changeViews,
                          onEnterSignIn: () =>
                              setState(() => changeViews = false),
                          onEnterSignUp: () =>
                              setState(() => changeViews = true),
                        ),
                      ),
                    )
                  ],
                )
              : SafeArea(
                  child: buildAuthentication(
                    changeViews: changeViews,
                    onEnterSignIn: () => setState(() => changeViews = false),
                    onEnterSignUp: () => setState(() => changeViews = true),
                  ),
                ),
        );
      },
    );
  }

  Widget buildAuthentication(
      {bool changeViews = false,
      void Function()? onEnterSignIn,
      void Function()? onEnterSignUp}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          changeViews
              ? AuthenticationLoginWidget(onEnter: onEnterSignIn)
              : FadeIn(
                  child: AuthenticationRegisterWidget(onEnter: onEnterSignUp))
        ],
      ),
    );
  }
}

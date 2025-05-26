import 'dart:io';

import 'package:app_ui/app_ui.dart' as App;
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/sign_up.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:notifications_repository/notifications_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:snap_alanaam_blocks_ui/snap_alanaam_blocks_ui.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _avatarFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        notificationsRepository: context.read<NotificationsRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: App.AppScaffold(
          releaseFocus: true,
          resizeToAvoidBottomInset: true,
          body: App.AppConstrainedScrollView(
              padding: EdgeInsets.symmetric(horizontal: App.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          AppLogo(
                            fit: BoxFit.fill,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: App.xxl * 2,
                          ),
                          Text(
                            context.l10n.loginText,
                            style: context.titleLarge,
                          ),
                          SizedBox(
                            height: App.xl,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: AvatarImagePicker(
                        onUpload: (_, avatarFile) {
                          setState(() {
                            _avatarFile = avatarFile;
                          });
                        },
                      )),
                  Expanded(
                      child: Column(
                    children: [
                      const SignUpForm(),
                      SizedBox(
                        height: App.xl,
                      ),
                      SignUpButton(
                        avatarFile: _avatarFile,
                      ),
                    ],
                  )),
                  AlreadyHaveAnAccountButton(),
                ],
              ))),
    );
  }
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:user_repository/user_repository.dart';

class MnageForgotPasswordPage extends StatelessWidget {
  const MnageForgotPasswordPage({super.key});

  static Route<void> route() => PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return MnageForgotPasswordPage();
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManagePasswordCubit(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordCubit(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: ManageForgotPasswordView(),
    );
  }
}

class ManageForgotPasswordView extends StatelessWidget {
  const ManageForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final showForgotPassword =
        context.select((ManagePasswordCubit b) => b.state);
    return PageTransitionSwitcher(
      reverse: showForgotPassword,
      transitionBuilder: (
        child,
        animation,
        secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      child: showForgotPassword
          ? const ForgotPassView()
          : const ResetPasswordView(),
    );
  }
}

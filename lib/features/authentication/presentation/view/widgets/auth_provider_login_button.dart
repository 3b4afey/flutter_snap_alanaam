import 'package:app_ui/app_ui.dart' as AppSpacing;
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/login.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class AuthProviderSignInButton extends StatelessWidget {
  const AuthProviderSignInButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final AuthProvider provider;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginCubit cubit) => switch (provider) {
        AuthProvider.google => cubit.state.status.isGoogleAuthInProgress,
        AuthProvider.facebook => cubit.state.status.isFaceBookAuthInProgress,
      },
    );
    final effectiveIcon = switch (provider) {
      AuthProvider.facebook => Assets.icons.facebook.svg(),
      AuthProvider.google => Assets.icons.google.svg(),
    };
    final icon = SizedBox.square(
      dimension: 24,
      child: effectiveIcon,
    );
    return Container(
      constraints: BoxConstraints(
        minWidth: switch (context.screenWidth) {
          > 600 => context.screenWidth * .6,
          _ => context.screenWidth,
        },
      ),
      margin: EdgeInsets.only(bottom: AppSpacing.md),
      child: Tappable.faded(
        throttle: true,
        throttleDuration: 650.ms,
        backgroundColor: context.theme.focusColor,
        borderRadius: BorderRadius.circular(AppSpacing.defaultBorderRadius),
        onTap: isInProgress ? null : onPressed,
        child: isInProgress
            ? Center(child: AppCircularProgress(context.adaptiveColor))
            : Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.s),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: icon),
                    SizedBox(
                      width: AppSpacing.s,
                    ),
                    Flexible(
                      child: Text(
                        context.l10n.signInWithText(provider.value),
                        style: context.labelLarge?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

enum AuthProvider {
  facebook('Facebook'),
  google('Google');

  const AuthProvider(this.value);

  final String value;
}

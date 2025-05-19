import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class ChangePasswordOtpField extends StatefulWidget {
  const ChangePasswordOtpField({super.key});

  @override
  State<ChangePasswordOtpField> createState() => _ChangePasswordFieldState();
}

class _ChangePasswordFieldState extends State<ChangePasswordOtpField> {
  late Debouncer _debouncer;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer();
    final cubit = context.read<ChangePasswordCubit>()..resetState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onOtpUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpError = context.select(
      (ChangePasswordCubit cubit) => cubit.state.otp.errorMessage,
    );
    final isLoading = context.select(
      (ChangePasswordCubit cubit) => cubit.state.status.isLoading,
    );

    return AppTextField(
      filled: true,
      enabledBorder: outlinedBorder(),
      border: outlinedBorder(),
      disabledBorder: outlinedBorder(),
      focusedBorder: outlinedBorder(),
      focusNode: _focusNode,
      hintText: context.l10n.loginText,
      enabled: !isLoading,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.number,
      autofillHints: const [AutofillHints.oneTimeCode],
      onChanged: (v) => _debouncer.run(
        () => context.read<ChangePasswordCubit>().onOtpChanged(v),
      ),
      errorText: otpError,
    );
  }
}

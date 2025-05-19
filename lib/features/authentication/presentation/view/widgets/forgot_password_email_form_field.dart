import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class ForgotPasswordEmailFormField extends StatefulWidget {
  const ForgotPasswordEmailFormField({super.key});

  @override
  State<ForgotPasswordEmailFormField> createState() =>
      _ForgotPasswordEmailFormField();
}

class _ForgotPasswordEmailFormField
    extends State<ForgotPasswordEmailFormField> {
  late FocusNode _focusNode;
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_focusNodeListener);
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) {
      context.read<ForgotPasswordCubit>().onEmailUnfocused();
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailError = context
        .select((ForgotPasswordCubit cubit) => cubit.state.email.errorMessage);
    return App.AppTextField(
      autofillHints: [AutofillHints.email],
      enabledBorder: App.outlinedBorder(),
      border: App.outlinedBorder(),
      disabledBorder: App.outlinedBorder(),
      focusedBorder: App.outlinedBorder(),
      errorText: emailError,
      filled: true,
      labelText: context.l10n.emailText,
      focusNode: _focusNode,
      hintText: context.l10n.loginText,
      hintStyle: context.labelLarge!.copyWith(
        color: Colors.grey,
      ),
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) => _debouncer.run(() {
        context.read<ForgotPasswordCubit>().onEmailChanged(value);
      }),
    );
  }
}

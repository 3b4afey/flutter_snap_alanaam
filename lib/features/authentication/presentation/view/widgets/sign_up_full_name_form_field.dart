import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/sign_up.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class SignUpFullNameFormField extends StatefulWidget {
  const SignUpFullNameFormField({super.key});

  @override
  State<SignUpFullNameFormField> createState() => _SignUpFullNameFormField();
}

class _SignUpFullNameFormField extends State<SignUpFullNameFormField> {
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
      context.read<SignUpCubit>().onFullNameUnfocused();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((SignUpCubit cubit) => cubit.state.submissionStatus.isLoading);
    final fullName = context
        .select((SignUpCubit cubit) => cubit.state.fullName.errorMessage);
    return App.AppTextField(
      autofillHints: [AutofillHints.givenName],
      enabled: !isLoading,
      enabledBorder: App.outlinedBorder(),
      border: App.outlinedBorder(),
      disabledBorder: App.outlinedBorder(),
      focusedBorder: App.outlinedBorder(),
      errorText: fullName,
      filled: true,
      labelText: context.l10n.emailText,
      focusNode: _focusNode,
      hintText: context.l10n.loginText,
      hintStyle: context.labelLarge!.copyWith(
        color: Colors.grey,
      ),
      textCapitalization: TextCapitalization.words,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) => _debouncer.run(() {
        context.read<SignUpCubit>().onFullNameChanged(value);
      }),
    );
  }
}

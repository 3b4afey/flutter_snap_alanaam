import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/login.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class EmailFormField extends StatefulWidget {
  const EmailFormField({super.key});

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_focusNodeListener);
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) {
      context.read<LoginCubit>().onEmailUnfocused();
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailError =
        context.select((LoginCubit cubit) => cubit.state.email.errorMessage);
    return App.AppTextField(
      autofillHints: [AutofillHints.email],
      enabledBorder: App.outlinedBorder(),
      border: App.outlinedBorder(),
      disabledBorder: App.outlinedBorder(),
      focusedBorder: App.outlinedBorder(),
      errorText: emailError,
      filled: true,
      textController: _controller,
      labelText: context.l10n.emailText,
      focusNode: _focusNode,
      hintText: context.l10n.loginText,
      hintStyle: context.labelLarge!.copyWith(
        color: Colors.grey,
      ),
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) => _debouncer.run(() {
        context.read<LoginCubit>().onEmailChanged(value);
      }),
    );
  }
}

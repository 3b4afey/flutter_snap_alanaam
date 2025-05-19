import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/login.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key});

  @override
  State<PasswordFormField> createState() => _PasswordFormField();
}

class _PasswordFormField extends State<PasswordFormField> {
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
      context.read<LoginCubit>().onPasswordUnfocused();
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordError =
        context.select((LoginCubit cubit) => cubit.state.password.errorMessage);

    final showPassword =
        context.select((LoginCubit cubit) => cubit.state.showPassword);

    return App.AppTextField(
      obscureText: !showPassword,
      suffixIcon: App.Tappable(
          backgroundColor: App.AppColors.transparent,
          onTap: context.read<LoginCubit>().changePasswordVisibility,
          child: Icon(
            !showPassword ? Icons.visibility : Icons.visibility_off,
            color: context.customAdaptiveColor(light: App.AppColors.grey),
          )),
      errorText: passwordError,
      filled: true,
      textController: _controller,
      labelText: context.l10n.passwordText,
      focusNode: _focusNode,
      hintText: context.l10n.passwordText,
      hintStyle: context.labelLarge!.copyWith(
        color: Colors.grey,
      ),
      enabledBorder: App.outlinedBorder(),
      border: App.outlinedBorder(),
      disabledBorder: App.outlinedBorder(),
      focusedBorder: App.outlinedBorder(),
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onChanged: (value) => _debouncer.run(() {
        context.read<LoginCubit>().onPasswordChanged(value);
      }),
    );
  }
}

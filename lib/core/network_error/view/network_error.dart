import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

/// {@template network_error}
/// A network error alert.
/// {@endtemplate}
class NetworkError extends StatelessWidget {
  /// {@macro network_error}
  const NetworkError({super.key, this.onRetry});

  /// An optional callback which is invoked when the retry button is pressed.
  final VoidCallback? onRetry;

  /// Route constructor to display the widget inside a [Scaffold].
  static Route<void> route({VoidCallback? onRetry}) {
    return PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) => Scaffold(
        body: Center(
          child: NetworkError(onRetry: onRetry),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap.v(xl),
        Icon(
          Icons.error_outline,
          size: 80,
          color: context.adaptiveColor,
        ),
        Gap.v(l),
        Text(
          l10n.loginText,
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        Gap.v(l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: xxl),
          child: AppButton(
            onPressed: onRetry,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 0,
                  child: Icon(Icons.refresh, size: AppSize.iconSize),
                ),
                Gap.h(s),
                Flexible(
                  child: Text(
                    l10n.loginText,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap.v(xl),
      ],
    );
  }
}

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/categories/presentation/categories.dart';

class CustomCategoriesView extends StatelessWidget {
  const CustomCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCategoriesPage();
  }
}

class CustomCategoriesPage extends StatelessWidget {
  const CustomCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        resizeToAvoidBottomInset: true,
        releaseFocus: true,
        safeArea: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CategoriesGrid(),
        ));
  }
}

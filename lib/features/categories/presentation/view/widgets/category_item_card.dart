import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/app/app.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class CategoryItemCard extends StatelessWidget {
  final String? image, categoryName;

  CategoryItemCard({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> context.pushNamed(
      AppRoutes.reels.name,
    ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF252525),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 54,
              backgroundColor: Colors.transparent,
              foregroundImage: ResizeImage.resizeIfNeeded(
                100,
                100,
                Assets.images.photos.camelCategory.provider(),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              context.l10n.loginText,
              style: context.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}

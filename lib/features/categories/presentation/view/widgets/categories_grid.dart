import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/categories/presentation/categories.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 18,
        // shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 30,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => CategoryItemCard(),
      ),
    );
  }
}

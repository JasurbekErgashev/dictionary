import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigateHomeButton extends StatelessWidget {
  const NavigateHomeButton({required this.width, super.key});

  final double width;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.go(AppRoute.home),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(width, 60)),
        backgroundColor: MaterialStateProperty.all(AppColors.periwinkle),
        foregroundColor: MaterialStateProperty.all(AppColors.blueGrey),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      icon: const Icon(Icons.arrow_forward_rounded),
      label: const Text('Kirish', style: AppTypography.p),
    );
  }
}

import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class SelectTypeButton extends StatelessWidget {
  const SelectTypeButton({
    required this.onPressed,
    required this.title,
    required this.buttonWidth,
    this.isActice = false,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final bool isActice;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: buttonWidth,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isActice ? AppColors.blueGrey : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              spreadRadius: -5,
              blurRadius: 15,
              color: AppColors.blueGrey10,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActice ? AppColors.white : AppColors.blueGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

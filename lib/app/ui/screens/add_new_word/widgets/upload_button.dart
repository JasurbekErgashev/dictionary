import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({required this.onTap, this.isLoading = false, super.key});

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? () {} : onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(
          const Size.fromHeight(60),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.blueGrey,
        ),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      icon: const Icon(Icons.upload_rounded),
      label: isLoading
          ? const CircularProgressIndicator(color: AppColors.white)
          : const Text('Yuklash', style: AppTypography.p),
    );
  }
}

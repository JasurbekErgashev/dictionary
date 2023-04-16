import 'package:avatar_glow/avatar_glow.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class MicGrower extends StatelessWidget {
  const MicGrower({super.key});

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: AppColors.blue,
      endRadius: 90.0,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: const Duration(milliseconds: 100),
      child: Material(
        elevation: 8.0,
        shape: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: AppColors.grey100,
          radius: 40.0,
          child: const Icon(Icons.mic_rounded, size: 45),
        ),
      ),
    );
  }
}

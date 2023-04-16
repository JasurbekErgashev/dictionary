import 'package:avatar_glow/avatar_glow.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class MicGrower extends StatelessWidget {
  const MicGrower({required this.onTap, this.isNotListening = true, super.key});

  final VoidCallback onTap;
  final bool isNotListening;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: AppColors.blue,
      endRadius: 60.0,
      duration: const Duration(milliseconds: 2000),
      repeat: !isNotListening,
      showTwoGlows: true,
      repeatPauseDuration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 8.0,
          shape: const CircleBorder(),
          child: CircleAvatar(
            backgroundColor: AppColors.grey100,
            radius: 35.0,
            child: Icon(
              !isNotListening ? Icons.mic_rounded : Icons.mic_off_rounded,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

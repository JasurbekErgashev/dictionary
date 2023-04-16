import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class ResultDefinitionScreenData {
  ResultDefinitionScreenData({
    required this.title,
    required this.type,
    required this.description,
  });
  final String title;
  final String type;
  final String description;
}

class ResultDefinitionScreen extends StatelessWidget {
  const ResultDefinitionScreen({required this.data, super.key});

  final ResultDefinitionScreenData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 25,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blueGrey,
          ),
        ),
        title: Text(data.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.type, style: AppTypography.pSBlue),
            Text(data.description, style: AppTypography.h3)
          ],
        ),
      ),
    );
  }
}

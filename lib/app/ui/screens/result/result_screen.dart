import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ResultScreenData {
  ResultScreenData({
    required this.title,
    required this.mainContent,
    this.subContent,
  });
  final String title;
  final String mainContent;
  final String? subContent;
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({required this.data, super.key});

  final ResultScreenData data;

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
            data.subContent == null
                ? const SizedBox()
                : Text(data.subContent!, style: AppTypography.pSBlue),
            HtmlWidget(data.mainContent, textStyle: AppTypography.h3),
          ],
        ),
      ),
    );
  }
}

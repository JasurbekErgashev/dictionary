import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ResultScreenData {
  ResultScreenData({required this.title, required this.mainContent, this.pron});
  final String title;
  final String? pron;
  final String mainContent;
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
            // TODO
            data.pron == null ? const SizedBox() : Text(data.pron!),
            Html(data: data.mainContent),
          ],
        ),
      ),
    );
  }
}

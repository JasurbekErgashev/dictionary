import 'package:dictionary/app/ui/screens/pdf_download/widgets/download_button.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class PdfDownloadScreen extends StatelessWidget {
  const PdfDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 25,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blueGrey,
          ),
        ),
        title: const Text('PDF shaklda yuklab olish'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            DownloadButton(title: 'Download Eng-Uzb'),
            SizedBox(height: 16),
            DownloadButton(title: 'Download Uzb-Eng'),
            SizedBox(height: 16),
            DownloadButton(title: 'Download Eng-Def'),
          ],
        ),
      ),
    );
  }
}

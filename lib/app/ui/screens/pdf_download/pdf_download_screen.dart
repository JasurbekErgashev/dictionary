// ignore_for_file: deprecated_member_use, unused_local_variable

import 'dart:io';

import 'package:dictionary/app/ui/screens/pdf_download/pdf_download_screen_view_model.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final pdf = await PDFGenerator.generatePDF();
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final file = File('$path/dictionary.pdf');
        // await file.writeAsBytes(await pdf.save());
        const url = 'file:///example.pdf';

        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: const Text('Download PDF'),
    );
  }
}

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
      body: const DownloadButton(),
    );
  }
}

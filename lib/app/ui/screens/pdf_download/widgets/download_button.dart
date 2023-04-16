// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dictionary/app/ui/screens/pdf_download/pdf_download_screen_view_model.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.download_rounded),
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
      onPressed: () async {
        final pdf = await PDFGenerator.generatePDF();
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final file = File('$path/dictionary.pdf');
        // TODO:
      },
      label: Text(title),
    );
  }
}

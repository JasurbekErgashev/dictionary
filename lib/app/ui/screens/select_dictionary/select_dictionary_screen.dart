import 'package:dictionary/app/ui/screens/select_dictionary/select_dictionary_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/select_dictionary/widgets/select_type_button.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class SelectDictionaryScreen extends StatefulWidget {
  const SelectDictionaryScreen({required this.viewModel, super.key});

  final SelectDictionaryScreenViewModel viewModel;

  @override
  State<SelectDictionaryScreen> createState() => _SelectDictionaryScreenState();
}

class _SelectDictionaryScreenState extends State<SelectDictionaryScreen> {
  bool englishUzbek = false;
  bool uzbekEnglish = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Assalomu Alaykum 🤗',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lug\'at turini tanlang',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              SelectTypeButton(
                onPressed: () {
                  setState(() {
                    englishUzbek = true;
                    uzbekEnglish = false;
                  });
                },
                title: 'English-Uzbek',
                buttonWidth: widget.viewModel.buttonWidth(context),
                isActice: englishUzbek,
              ),
              const SizedBox(height: 16),
              SelectTypeButton(
                onPressed: () {
                  setState(() {
                    englishUzbek = false;
                    uzbekEnglish = true;
                  });
                },
                title: 'O\'zbekcha-Inglizcha',
                buttonWidth: widget.viewModel.buttonWidth(context),
                isActice: uzbekEnglish,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

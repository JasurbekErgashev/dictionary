import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/app/ui/screens/select_dictionary/select_dictionary_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/select_dictionary/widgets/select_type_button.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              const Text('Assalomu Alaykum 🤗', style: AppTypography.h2),
              const SizedBox(height: 8),
              const Text('Lug\'at turini tanlang', style: AppTypography.h2),
              const SizedBox(height: 32),
              SelectTypeButton(
                onPressed: () {
                  setState(() {
                    englishUzbek = true;
                    uzbekEnglish = false;
                  });
                  context.go(AppRoute.home);
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
                  context.go(AppRoute.home);
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

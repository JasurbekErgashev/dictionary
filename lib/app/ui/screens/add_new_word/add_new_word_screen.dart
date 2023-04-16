import 'package:dictionary/app/ui/screens/add_new_word/add_new_word_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/add_new_word/widgets/upload_button.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/domain/bloc/newword_bloc.dart';
import 'package:dictionary/domain/state/add_word_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddNewWordScreen extends StatefulWidget {
  const AddNewWordScreen({required this.viewModel, super.key});

  final AddNewWordScreenViewModel viewModel;

  @override
  State<AddNewWordScreen> createState() => _AddNewWordScreenState();
}

class _AddNewWordScreenState extends State<AddNewWordScreen> {
  final TextEditingController _text1Controller = TextEditingController();
  final TextEditingController _text2Controller = TextEditingController();

  @override
  void dispose() {
    _text1Controller.dispose();
    _text2Controller.dispose();
    super.dispose();
  }

  var typIndex = 1;

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
        title: const Text('Yangi so\'z qo\'shish'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SelectionBox(
                  onTap: () {
                    setState(() {
                      typIndex = 1;
                    });
                  },
                  title: 'Eng-Uzb',
                  isActive: typIndex == 1,
                ),
                const SizedBox(width: 16),
                SelectionBox(
                  onTap: () {
                    setState(() {
                      typIndex = 2;
                    });
                  },
                  title: 'Uzb-Eng',
                  isActive: typIndex == 2,
                ),
                const SizedBox(width: 16),
                SelectionBox(
                  onTap: () {
                    setState(() {
                      typIndex = 3;
                    });
                  },
                  title: 'Eng-Def',
                  isActive: typIndex == 3,
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _text1Controller,
              style: AppTypography.pSmall,
              cursorColor: AppColors.black,
              decoration: appTextFieldDecoration(
                hintText: typIndex == 2 ? 'uzb' : 'eng',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _text2Controller,
              style: AppTypography.pSmall,
              cursorColor: AppColors.black,
              decoration: appTextFieldDecoration(
                hintText: typIndex == 1
                    ? 'uzb'
                    : typIndex == 2
                        ? 'eng'
                        : 'def',
              ),
            ),
            const SizedBox(height: 16),
            BlocConsumer<AddNewWordBloc, AddWordState>(
              buildWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state is SuccessAddWordState) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: 'muvaffaqiyatli qo\'shildi',
                    ),
                    dismissType: DismissType.onSwipe,
                    dismissDirection: [DismissDirection.up],
                  );
                }
                if (state is FailedAddWordState) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'Siz kiritgan so\'z allaqachon mavjud',
                    ),
                    dismissType: DismissType.onSwipe,
                    dismissDirection: [DismissDirection.up],
                  );
                }
              },
              builder: (context, state) => UploadButton(
                isLoading: state is LoadingAddWordState,
                onTap: () {
                  widget.viewModel.uploadNewWord(
                    context,
                    text1: _text1Controller.text,
                    text2: _text2Controller.text,
                    index: typIndex,
                  );
                  _text1Controller.clear();
                  _text2Controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectionBox extends StatelessWidget {
  const SelectionBox({
    required this.onTap,
    required this.title,
    this.isActive = false,
    super.key,
  });
  final VoidCallback onTap;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.blueGrey : AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: AppTypography.pSmall.copyWith(
              color: isActive ? AppColors.white : AppColors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}

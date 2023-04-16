import 'package:dictionary/app/ui/screens/definition/definition_screen_view_model.dart';
import 'package:dictionary/app/ui/widgets/dictionary_list.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/definition.dart';
import 'package:dictionary/domain/bloc/definition_bloc.dart';
import 'package:dictionary/domain/state/definition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefinitionScreen extends StatefulWidget {
  const DefinitionScreen({required this.viewModel, super.key});

  final DefinitionScreenViewModel viewModel;

  @override
  State<DefinitionScreen> createState() => _DefinitionScreenState();
}

class _DefinitionScreenState extends State<DefinitionScreen> {
  final TextEditingController _searchController = TextEditingController();

  late List<Definition> defs;

  List<Definition> foundDefs = [];

  @override
  void initState() {
    super.initState();
    widget.viewModel.getDefs(context);
  }

  void _runFilter(String ek) {
    if (ek.isEmpty) {
      setState(() {
        foundDefs = defs;
      });
    } else {
      setState(() {
        foundDefs = defs
            .where((d) => d.word.toLowerCase().startsWith(ek.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  bool isSearchVisible = false;
  bool isFirstLaunch = true;

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
        title: SizedBox(
          height: 45,
          child: TextField(
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  isSearchVisible = false;
                } else {
                  isSearchVisible = true;
                }
              });
              _runFilter(value);
            },
            controller: _searchController,
            style: AppTypography.pSmall,
            cursorColor: AppColors.black,
            decoration: appTextFieldDecoration(
              hintText: 'qidirish...',
              suffixIcon: !isSearchVisible
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          isSearchVisible = false;
                        });
                        _runFilter('');
                      },
                      splashRadius: 25,
                      icon: SvgPicture.asset(AppAssets.close),
                    ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: BlocBuilder<DefinitionBloc, DefinitionState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is LoadingDefinitionState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blueGrey,
                  ),
                );
              }
              if (state is SuccessDefinitionState) {
                defs = state.defs;
                if (isFirstLaunch) {
                  foundDefs = defs;
                  isFirstLaunch = false;
                }
                return DefList(defs: foundDefs, viewModel: widget.viewModel);
              } else {
                return const Center(
                  child: Text('Something Went Wrong', style: AppTypography.p),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset(AppAssets.mic),
      ),
    );
  }
}

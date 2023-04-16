import 'package:dictionary/app/ui/screens/definition/definitin_list.dart';
import 'package:dictionary/app/ui/screens/home/home_screen_view_model.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/definition.dart';
import 'package:dictionary/domain/bloc/dictionary_bloc.dart';
import 'package:dictionary/domain/state/dictionary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefinitionScreen extends StatefulWidget {
  const DefinitionScreen({required this.viewModel, super.key});

  final HomeScreenViewModel viewModel;

  @override
  State<DefinitionScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefinitionScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();

  late List<Definition> words;

  List<Definition> foundWords = [];

  @override
  void initState() {
    super.initState();
    widget.viewModel.getWords(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
  }

  void _runFilter(String ek) {
    if (ek.isEmpty) {
      setState(() {
        foundWords = words;
      });
    } else {
      setState(() {
        foundWords = words
            .where(
              (word) => word.word.toLowerCase().startsWith(ek.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _searchController.dispose();
  }

  bool isSearchVisible = false;
  bool isFirstLaunch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              hintText: 'Search...',
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
          child: BlocBuilder<DictionaryBloc, DictionaryState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is LoadingDictionaryState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blueGrey,
                  ),
                );
              }
              if (state is SuccessDictionaryState) {
                words = state.defWords;
                if (isFirstLaunch) {
                  foundWords = words;
                  isFirstLaunch = false;
                }
                return DefinitionList(
                    defWords: foundWords, viewModel: widget.viewModel);
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

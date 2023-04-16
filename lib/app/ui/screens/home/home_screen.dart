import 'package:dictionary/app/ui/screens/home/home_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/home/widgets/custom_drawer.dart';
import 'package:dictionary/app/ui/widgets/dictionary_list.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:dictionary/domain/bloc/dictionary_bloc.dart';
import 'package:dictionary/domain/state/dictionary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.viewModel, super.key});

  final HomeScreenViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();

  late List<EngUzb> engUzbWords;
  late List<UzbEng> uzbEngWords;

  List<EngUzb> foundEngUzbWords = [];
  List<UzbEng> foundUzbEngWords = [];

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
        foundEngUzbWords = engUzbWords;
        foundUzbEngWords = uzbEngWords;
      });
    } else {
      setState(() {
        foundEngUzbWords = engUzbWords
            .where(
              (word) => word.eng.toLowerCase().startsWith(ek.toLowerCase()),
            )
            .toList();
        foundUzbEngWords = uzbEngWords
            .where(
              (word) => word.uzb.toLowerCase().startsWith(ek.toLowerCase()),
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

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        dividerColor: AppColors.transparent,
        onTap: (_) {
          _searchController.clear();
          setState(() {
            foundEngUzbWords = engUzbWords;
            foundUzbEngWords = uzbEngWords;
          });
        },
        tabs: const [
          Tab(text: 'English-Uzbek'),
          Tab(text: 'O\'zbekcha-Inglizcha'),
        ],
      );

  bool isSearchVisible = false;
  bool isFirstLaunch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          splashRadius: 25,
          icon: SvgPicture.asset(AppAssets.menu),
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
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 25,
            icon: SvgPicture.asset(AppAssets.definition),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: _tabBar,
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
                engUzbWords = state.engUzbWords;
                uzbEngWords = state.uzbEngWords;
                if (isFirstLaunch) {
                  foundEngUzbWords = engUzbWords;
                  foundUzbEngWords = uzbEngWords;
                  isFirstLaunch = false;
                }
                return TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    EngUzbList(
                      engUzbWords: foundEngUzbWords,
                      viewModel: widget.viewModel,
                    ),
                    UzbEngList(
                      uzbEngWords: foundUzbEngWords,
                      viewModel: widget.viewModel,
                    ),
                  ],
                );
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

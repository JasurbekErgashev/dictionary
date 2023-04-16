// ignore_for_file: unused_field

import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/app/ui/screens/home/home_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/home/widgets/custom_drawer.dart';
import 'package:dictionary/app/ui/widgets/dictionary_list.dart';
import 'package:dictionary/app/ui/widgets/mic_grower.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:dictionary/data/storage/dictionary_type_storage.dart';
import 'package:dictionary/domain/bloc/dictionary_bloc.dart';
import 'package:dictionary/domain/state/dictionary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.viewModel, super.key});

  final HomeScreenViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool isListening = false;
  String _lastWords = '';

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    isListening = true;
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    isListening = false;
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _searchController.text = _lastWords;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  final TextEditingController _searchController = TextEditingController();
  final DictionaryTypeStorage storage = DictionaryTypeStorage();

  late List<EngUzb> engUzbWords;
  late List<UzbEng> uzbEngWords;

  List<EngUzb> foundEngUzbWords = [];
  List<UzbEng> foundUzbEngWords = [];

  @override
  void initState() {
    super.initState();
    widget.viewModel.getWords(context);
    _initSpeech();
    _searchController.addListener(() {
      _runFilter(_searchController.text);
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(storage.dictTypeKey!);
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
        onTap: (value) {
          _searchController.clear();
          setState(() {
            foundEngUzbWords = engUzbWords;
            foundUzbEngWords = uzbEngWords;
          });
          storage.saveDictTypeKey(value);
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
      drawer: CustomDrawer(storage: storage, tabController: _tabController),
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
                _runFilter(value);
              });
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
            onPressed: () => context.push(AppRoute.definition),
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
      floatingActionButton: MicGrower(
        onTap: _speechToText.isNotListening ? _startListening : _stopListening,
        isNotListening: !isListening,
      ),
    );
  }
}

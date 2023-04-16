import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/app/ui/screens/search_online/search_online_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/search_online/widgets/main_container.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/domain/bloc/online_dictionary_bloc.dart';
import 'package:dictionary/domain/state/online_dictionary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchOnlineScreen extends StatefulWidget {
  const SearchOnlineScreen({required this.viewmodel, super.key});

  final SearchOnlineScreenViewModel viewmodel;

  @override
  State<SearchOnlineScreen> createState() => _SearchOnlineScreenState();
}

class _SearchOnlineScreenState extends State<SearchOnlineScreen> {
  final TextEditingController _searchController = TextEditingController();

  late StreamSubscription<PlayerState> playerStateSubscription;
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    widget.viewmodel.setInitial(context);
    playerStateSubscription = player.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    playerStateSubscription.cancel();
    _searchController.dispose();
    super.dispose();
  }

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
        title: const Text('Onlayn Qidirish'),
      ),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  style: AppTypography.pSmall,
                  cursorColor: AppColors.black,
                  decoration: appTextFieldDecoration(
                    hintText: 'qidirish...',
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.black,
                    ),
                  ),
                  onSubmitted: (_) {
                    if (_searchController.text.isNotEmpty) {
                      widget.viewmodel.searchKeyword(
                        context,
                        keyword: _searchController.text,
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      widget.viewmodel.searchKeyword(
                        context,
                        keyword: _searchController.text,
                      );
                      FocusScope.of(context).unfocus();
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 60),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.blueGrey),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Text('Qidirish', style: AppTypography.p),
                ),
                const SizedBox(height: 16),
                BlocBuilder<OnlineDictionaryBloc, OnlineDictionaryState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is LoadingOnlineDictionaryState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blueGrey,
                        ),
                      );
                    } else if (state is SuccessOnlineDictionaryState) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MainContainer(
                            od: state.results[index],
                            playAudio: (String url) async {
                              if (!isPlaying) {
                                await player.play(UrlSource(url));
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                        itemCount: state.results.length,
                      );
                    } else if (state is FailedOnlineDictionaryState) {
                      return Center(
                        child: Text(
                          'Xatolik yuz berdi. Internet aloqasi mavjudligiga ishonch hosil qiling.',
                          textAlign: TextAlign.center,
                          style: AppTypography.pSmallBlueGrey,
                        ),
                      );
                    } else if (state is NotFoundOnlineDictionaryState) {
                      return Center(
                        child: Text(
                          'Ma\'lumot topilmadi.',
                          textAlign: TextAlign.center,
                          style: AppTypography.pSmallBlueGrey,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

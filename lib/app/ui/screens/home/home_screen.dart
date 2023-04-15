import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/app/ui/screens/result/result_screen.dart';
import 'package:dictionary/app/ui/widgets/dictionary_litem.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dictionary_db.dart';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        dividerColor: AppColors.transparent,
        tabs: const [
          Tab(text: 'English-Uzbek'),
          Tab(text: 'O\'zbekcha-Inglizcha'),
        ],
      );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          splashRadius: 25,
          icon: SvgPicture.asset(AppAssets.menu),
        ),
        title: SizedBox(
          height: 45,
          child: TextField(
            style: AppTypography.pSmall,
            cursorColor: AppColors.black,
            decoration: appTextFieldDecoration(
              hintText: 'Search...',
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(AppAssets.close),
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
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder<List<EngUzb>>(
                future: DictionaryDatabase.instance.getAllEngUzbWords(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<EngUzb>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => context.push(
                              AppRoute.result,
                              extra: ResultScreenData(
                                title: snapshot.data![index].eng,
                                mainContent: snapshot.data![index].uzb,
                                pron: snapshot.data![index].pron,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Ink(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(snapshot.data![index].eng,
                                  style: AppTypography.p),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
                  } else {
                    return const Text('Something went so wrong');
                  }
                },
              ),
              FutureBuilder<List<UzbEng>>(
                future: DictionaryDatabase.instance.getAllUzbEngWords(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<UzbEng>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => context.push(
                              AppRoute.result,
                              extra: ResultScreenData(
                                title: snapshot.data![index].uzb,
                                mainContent: snapshot.data![index].eng,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Ink(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(snapshot.data![index].uzb,
                                  style: AppTypography.p),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
                  } else {
                    return const Text('Something went so wrong');
                  }
                },
              ),
            ],
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

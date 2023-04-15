import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/app/ui/widgets/text_field_decoration.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(words[index], style: AppTypography.p),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: words.length,
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(words[index], style: AppTypography.p),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: words.length,
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

const words = [
  "amplify",
  "hazardous",
  "forsake",
  "gratitude",
  "dazzling",
  "luminous",
  "obscure",
  "vivid",
  "crimson",
  "glimpse",
  "subtle",
  "frenzy",
  "infamous",
  "pristine",
  "jovial",
  "gargantuan",
  "profound",
  "whirlwind",
  "thunderous",
  "nostalgic"
];

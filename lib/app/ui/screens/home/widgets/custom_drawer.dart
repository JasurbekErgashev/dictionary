import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/storage/dictionary_type_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    required this.storage,
    required this.tabController,
    super.key,
  });

  final DictionaryTypeStorage storage;
  final TabController tabController;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.lightLavender,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).padding.vertical,
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: AppColors.lightPeriwinkle,
              child: Image.asset(AppAssets.appLogo),
            ),
            const SizedBox(height: 16),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoute.searchOnline);
              },
              leading: const Icon(Icons.search_rounded),
              title: const Text('Online Qidirish'),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  if (widget.storage.dictTypeKey == 0) {
                    widget.storage.saveDictTypeKey(1);
                  } else {
                    widget.storage.saveDictTypeKey(0);
                  }
                });
                Navigator.pop(context);
                widget.tabController.animateTo(widget.storage.dictTypeKey!);
              },
              leading: const Icon(Icons.swap_horizontal_circle_sharp),
              title: Text(
                widget.storage.dictTypeKey == 0
                    ? 'English-Uzbek'
                    : 'O\'zbekcha-Inglizcha',
              ),
            ),
            ListTile(
              onTap: () {
                context.push(AppRoute.addNewWord);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.add_circle_rounded),
              title: const Text('So\'z qo\'shish'),
            ),
            ListTile(
              onTap: () {
                context.push(AppRoute.pdfDownload);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF shaklda yuklash'),
            ),
          ],
        ),
      ),
    );
  }
}

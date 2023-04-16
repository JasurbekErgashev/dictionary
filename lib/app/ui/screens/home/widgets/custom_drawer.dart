import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
            SizedBox(
              height: 150,
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
              onTap: () {},
              leading: const Icon(Icons.swap_horizontal_circle_sharp),
              title: const Text('O\'zgartirish'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.add_circle_rounded),
              title: const Text('Qo\'shish'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

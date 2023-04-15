// import 'package:dictionary/app/navigation/app_route.dart';
// import 'package:dictionary/constants/constants.dart';
// import 'package:dictionary/data/dto/eng_uzb.dart';
// import 'package:dictionary/data/dto/uzb_eng.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class DictionaryList extends StatelessWidget {
//   const DictionaryList({required this.engUzbWords,required this.uzbEngWords,  super.key});

//   final List<EngUzb>? engUzbWords;
//   final List<UzbEng>? uzbEngWords;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: () => context.push(AppRoute.result, extra: (engUzbWords ?? uzbEngWords!)[index]),
//           borderRadius: BorderRadius.circular(12),
//           child: Ink(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(words[index].eng, style: AppTypography.p),
//           ),
//         );
//       },
//       separatorBuilder: (context, index) => const SizedBox(height: 8),
//       itemCount: words.length,
//     );
//   }
// }

import 'package:flutter/material.dart';

class SelectDictionaryScreenViewModel {
  SelectDictionaryScreenViewModel();

  double buttonWidth(BuildContext context) {
    bool isP = MediaQuery.of(context).orientation == Orientation.portrait;
    return isP
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_pages/main_page.dart';
import '../app_pages/question_storage_page.dart';
import '../app_pages/score_table_page.dart';
import '../models/navigation_item.dart';
import '../provider/navigation_provider.dart';

Widget buildPages(BuildContext context) {
  final provider = Provider.of<NavigationProvider>(context);
  final navigationItem = provider.navigationItem;

  switch(navigationItem){
    case NavigationItem.home_filled:
      return MainPage();
    case NavigationItem.score:
      return ScoreTablePage();
    case NavigationItem.store:
      return QuestionStoragePage();
  }
}
import 'package:caretag/Modules/news/model/newsmodel.dart';
import 'package:caretag/Modules/news/model/repo.dart';
import 'package:flutter/material.dart';

class Newspage extends StatelessWidget {
  const Newspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            NewsRepo newsRepo = NewsRepo();
            //  NewsDataService newsDataService = NewsDataService();
            //  Text(newsDataService.fetchHealthCategory().toString());
            final data = await newsRepo.fetchHealthNews();
          },
          child: Text("Click me"),
        ),
      ),
    );
  }
}

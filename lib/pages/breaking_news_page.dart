import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/news_controller.dart';

class BreakingNewsPage extends StatelessWidget {
  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breaking News"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Obx(() {
        if (newsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: newsController.breakingNews.length,
            itemBuilder: (context, index) {
              final article = newsController.breakingNews[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleView(blogUrl: article.url!),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(article.urlToImage ?? 'default_image_url'),
                  title: Text(article.title ?? 'No title available'),
                  subtitle: Text(article.description ?? 'No description available'),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/show_category.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/show_category_news.dart';
import 'package:news_app/services/news_controller.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  final NewsController newsController = Get.put(NewsController());
  var categories = <ShowCategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    try {
      await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
      categories.assignAll(showCategoryNews.categories);
    } catch (e) {

      print("Error fetching news: $e");
    } finally {
      setState(() {
        isLoading.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Obx(() {
          return isLoading.value
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ShowCategory(
                      image:
                          categories[index].urlToImage ?? 'default_image_url',
                      desc: categories[index].description ??
                          'No description available',
                      title: categories[index].title ?? 'No title available',
                      url: categories[index].url ?? 'No url available',
                    );
                  },
                );
        }),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;
  ShowCategory(
      {required this.image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

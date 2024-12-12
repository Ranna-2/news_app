import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/news_controller.dart';
import 'package:news_app/services/slider_data.dart' as custom_slider;

class AllNews extends StatefulWidget {
  final String? news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  final NewsController newsController = Get.put(NewsController());
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];

  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSlider() async {
    custom_slider.Slider slider = new custom_slider.Slider();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.news ?? '') + "News",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Obx(() {
        if (newsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.news == "Breaking"
                ? newsController.sliders.length
                : newsController.articles.length,
            itemBuilder: (context, index) {
              return AllNewsSection(
                image: widget.news == "Breaking"
                    ? newsController.sliders[index].urlToImage ??
                        'default_image_url'
                    : newsController.articles[index].urlToImage!,
                desc: widget.news == "Breaking"
                    ? newsController.sliders[index].description ??
                        'No description available'
                    : newsController.articles[index].description!,
                title: widget.news == "Breaking"
                    ? newsController.sliders[index].title ??
                        'No title available'
                    : newsController.articles[index].title!,
                url: widget.news == "Breaking"
                    ? newsController.sliders[index].url ?? 'No url available'
                    : newsController.articles[index].url!,
              );
            },
          );
        }
      }),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String image, desc, title, url;
  AllNewsSection(
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

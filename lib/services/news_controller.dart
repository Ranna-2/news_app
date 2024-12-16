import 'package:get/get.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';


class NewsController extends GetxController {
  var articles = <ArticleModel>[].obs;
  var isLoading = true.obs;
  var sliders = <sliderModel>[].obs;
  var breakingNews = <ArticleModel>[].obs;

  @override
  void onInit() {
    fetchNews();
    fetchBreakingNews();
    super.onInit();
  }

  void fetchNews() async {
    isLoading(true);
    News newsService = News();
    await newsService.getNews();
    articles.assignAll(newsService.news);
    await fetchBreakingNews();
    isLoading(false);
  }

  void fetchSliders() async {
    isLoading(true);
    Slider sliderService = Slider();
    await sliderService.getSlider();
    sliders.assignAll(sliderService.sliders);
    isLoading(false);
  }
  Future <void> fetchBreakingNews() async {
    isLoading(true);
    News newsService = News();
    await newsService.getBreakingNews();
    breakingNews.assignAll(newsService.breakingNews);
    isLoading(false);
  }

}

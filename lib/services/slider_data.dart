import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/slider_model.dart';

class Slider{
  List<sliderModel> sliders=[];

  Future<void> getSlider()async{
    String url="https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=891ca059f9c346e58f8a74b84b4c37da";
    var response=await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          sliderModel slider=sliderModel(
            title:element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(slider);
        }

      });


    }
  }
}
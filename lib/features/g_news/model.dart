part of 'bloc.dart';

class GNewsData {

  late final int totalArticles;
  late final List<GArticles> articles;

  GNewsData.fromJson(Map<String, dynamic> json){
    totalArticles = json['totalArticles'];
    articles = List.from(json['articles']).map((e)=>GArticles.fromJson(e)).toList();
  }


}

class GArticles {

  late final String title;
  late final String description;
  late final String content;
  late final String url;
  late final String image;
  late final String publishedAt;
  late final Source source;

  GArticles.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    content = json['content'];
    url = json['url'];
    image = json['image'];
    publishedAt = json['publishedAt'];
    source = Source.fromJson(json['source']);
  }


}

class Source {

  late final String name;
  late final String url;

  Source.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }


}
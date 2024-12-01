part of 'bloc.dart';

class ANewsData {

  late final String status;
  late final int totalResults;
  late final List<AArticles> articles;

  ANewsData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    totalResults = json['totalResults'];
    articles = List.from(json['articles']).map((e)=>AArticles.fromJson(e)).toList();
  }


}

class AArticles {

  late final Source source;
  late final String? author;
  late final String title;
  late final String description;
  late final String url;
  late final String? urlToImage;
  late final String publishedAt;
  late final String? content;

  AArticles.fromJson(Map<String, dynamic> json){
    source = Source.fromJson(json['source']);
    author = null;
    title = json['title'];
    description = json['description']??"";
    url = json['url'];
    urlToImage = null;
    publishedAt = json['publishedAt'];
    content = null;
  }


}

class Source {

  late final String? id;
  late final String name;

  Source.fromJson(Map<String, dynamic> json){
    id = null;
    name = json['name'];
  }


}
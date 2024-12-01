part of 'bloc.dart';

class MarvelData {

  late final int code;
  late final String status;
  late final String copyright;
  late final String attributionText;
  late final String attributionHTML;
  late final String etag;
  late final Data data;

  MarvelData.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    etag = json['etag'];
    data = Data.fromJson(json['data']);
  }


}

class Data {

  late final int offset;
  late final int limit;
  late final int total;
  late final int count;
  late final List<MarvelModel> marvels;

  Data.fromJson(Map<String, dynamic> json){
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    marvels = List.from(json['results']).map((e)=>MarvelModel.fromJson(e)).toList();
  }


}

class MarvelModel {

  late final int id;
  late final String name;
  late final String description;
  late final String modified;
  late final Thumbnail thumbnail;
  late final String resourceURI;
  late final Comics comics;
  late final Series series;
  late final Stories stories;
  late final Events events;
  late final List<Urls> urls;

  MarvelModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
    resourceURI = json['resourceURI'];
    comics = Comics.fromJson(json['comics']);
    series = Series.fromJson(json['series']);
    stories = Stories.fromJson(json['stories']);
    events = Events.fromJson(json['events']);
    urls = List.from(json['urls']).map((e)=>Urls.fromJson(e)).toList();
  }


}

class Thumbnail {

  late final String path;
  late final String extension;

  Thumbnail.fromJson(Map<String, dynamic> json){
    path = json['path'];
    extension = json['extension'];
  }


}

class Comics {

  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Comics.fromJson(Map<String, dynamic> json){
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    returned = json['returned'];
  }


}

class Items {

  late final String resourceURI;
  late final String name;

  Items.fromJson(Map<String, dynamic> json){
    resourceURI = json['resourceURI'];
    name = json['name'];
  }


}

class Series {

  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Series.fromJson(Map<String, dynamic> json){
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    returned = json['returned'];
  }


}

class Stories {

  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Stories.fromJson(Map<String, dynamic> json){
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    returned = json['returned'];
  }


}

class Events {

  late final int available;
  late final String collectionURI;
  late final List<Items> items;
  late final int returned;

  Events.fromJson(Map<String, dynamic> json){
    available = json['available'];
    collectionURI = json['collectionURI'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    returned = json['returned'];
  }


}

class Urls {

  late final String type;
  late final String url;

  Urls.fromJson(Map<String, dynamic> json){
    type = json['type'];
    url = json['url'];
  }


}
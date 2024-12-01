part of 'bloc.dart';

class AllCategories{
  late List<String> categories;

  AllCategories.fromJson(dynamic json) {
    categories = json['categories'];
  }
}
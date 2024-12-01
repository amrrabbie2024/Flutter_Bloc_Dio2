class Category{
  final String image,title;

  Category({required this.image,required this.title});
}

List<Category> getCategories(){
  List<Category> categories=[];

  categories.add(Category(image: "general.jpg", title: "general"));
  categories.add(Category(image: "business.png", title: "business"));
  categories.add(Category(image: "entertainment.jpg", title: "entertainment"));
  categories.add(Category(image: "health.jpg", title: "health"));
  categories.add(Category(image: "science.jpg", title: "science"));
  categories.add(Category(image: "sports.png", title: "sports"));
  categories.add(Category(image: "technology.jpg", title: "technology"));

  return categories;
}
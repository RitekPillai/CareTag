class DiagonosticTestModel {
  final String title;
  final String discription;
  final double price;
  final String iconType;

  DiagonosticTestModel({
    required this.title,
    required this.discription,
    required this.price,
    required this.iconType,
  });

  factory DiagonosticTestModel.fromJson(Map<String, dynamic> json) {
    return DiagonosticTestModel(
      title: json['title'],
      discription: json['discription'],
      price: json['price'],
      iconType: json['iconType'],
    );
  }
}

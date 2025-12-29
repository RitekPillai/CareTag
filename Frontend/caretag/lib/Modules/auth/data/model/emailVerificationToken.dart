class Emailverificationtoken {
  final String Token;

  Emailverificationtoken({required this.Token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['token'] = Token;

    return data;
  }

  factory Emailverificationtoken.formJson(Map<String, dynamic> json) {
    return Emailverificationtoken(Token: json['token']);
  }
}

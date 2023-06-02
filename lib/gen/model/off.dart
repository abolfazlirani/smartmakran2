class OfflineSendedModel {
  int id;
  String title;
  String url;
  String body;
  String createdAt;
  String savedAt;
  bool sended;
  String pound;

  OfflineSendedModel({
    required this.id,
    required this.title,
    required this.url,
    required this.body,
    required this.createdAt,
    required this.savedAt,
    required this.sended,
    required this.pound,
  });

  factory OfflineSendedModel.fromJson(Map<String, dynamic> json) {
    return OfflineSendedModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      body: json['body'],
      createdAt: json['createdAt'],
      savedAt: json['savedAt'],
      sended: json['sended'],
      pound: json['pound'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'body': body,
      'createdAt': createdAt,
      'savedAt': savedAt,
      'sended': sended,
      'pound': pound,
    };
  }
}


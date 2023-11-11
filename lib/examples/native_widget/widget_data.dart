class WidgetData {
  WidgetData({required this.text});

  final String text;

  WidgetData.fromJson(Map<String, dynamic> json) : text = json['text'];
  Map<String, dynamic> toJson() => {'text': text};
}

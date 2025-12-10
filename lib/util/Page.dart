class Page {
  final String text;

  const Page({
    required this.text
  });

  factory Page.fromJson(Map<String, dynamic> json){
    return switch (json){
      {
      'text': String text,
      } => Page(text: text),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class UserNotification {
  final int id;
  final String title;
  final String content;

  UserNotification({
    required this.id,
    required this.title,
    required this.content,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}

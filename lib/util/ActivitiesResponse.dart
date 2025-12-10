class ActivitiesResponse {
  final List<Activity> videoActivities;
  final List<Activity> taskActivities;
  final List<Activity> exerciseActivities;

  ActivitiesResponse({
    required this.videoActivities,
    required this.taskActivities,
    required this.exerciseActivities,
  });

  factory ActivitiesResponse.fromJson(Map<String, dynamic> json) {
    return ActivitiesResponse(
      videoActivities: (json['video_activities'] as List)
          .map((item) => Activity.fromJson(item))
          .toList(),
      taskActivities: (json['task_activities'] as List)
          .map((item) => Activity.fromJson(item))
          .toList(),
      exerciseActivities: (json['exercise_activities'] as List)
          .map((item) => Activity.fromJson(item))
          .toList(),
    );
  }
}

class Activity {
  final String id;
  final String? title;
  final String? description;
  final Data? data;

  Activity({
    required this.id,
    this.title,
    this.description,
    this.data,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final List<Page>? pages;

  Data({this.pages});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pages: json['pages'] != null
          ? (json['pages'] as List)
          .map((item) => Page.fromJson(item))
          .toList()
          : null,
    );
  }
}

class Page {
  final String text;

  Page({required this.text});

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      text: json['text'],
    );
  }
}
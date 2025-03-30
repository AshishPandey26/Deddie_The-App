class Task {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;
  final bool isCompleted;
  final bool postToLinkedIn;
  final bool postToTwitter;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    this.isCompleted = false,
    this.postToLinkedIn = false,
    this.postToTwitter = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
    bool? postToLinkedIn,
    bool? postToTwitter,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      postToLinkedIn: postToLinkedIn ?? this.postToLinkedIn,
      postToTwitter: postToTwitter ?? this.postToTwitter,
    );
  }

  // Convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted,
      'postToLinkedIn': postToLinkedIn,
      'postToTwitter': postToTwitter,
    };
  }

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      isCompleted: json['isCompleted'],
      postToLinkedIn: json['postToLinkedIn'],
      postToTwitter: json['postToTwitter'],
    );
  }
}

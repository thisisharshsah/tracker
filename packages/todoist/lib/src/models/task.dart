import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.content,
    required this.projectId,
    this.sectionId,
    required this.order,
    required this.priority,
    required this.commentCount,
    required this.url,
    this.due,
    required this.labels,
    required this.isCompleted,
    required this.creatorId,
    this.assignerId,
    this.assigneeId,
    required this.createdAt,
    required this.description,
    this.duration,
    this.parentId,
  });

  final String id;
  final String content;
  final String projectId;
  final String? sectionId;
  final int order;
  final int priority;
  final int commentCount;
  final String url;
  final Due? due;
  final List<String> labels;
  final bool isCompleted;
  final String creatorId;
  final String? assignerId;
  final String? assigneeId;
  final DateTime createdAt;
  final String description;
  final TaskDuration? duration;
  final String? parentId;

  List<Object> get props => [
        id,
        content,
        projectId,
        sectionId!,
        order,
        priority,
        commentCount,
        url,
        due!,
        labels,
        isCompleted,
        creatorId,
        assignerId!,
        assigneeId!,
        createdAt,
        description,
        duration!,
        parentId!,
      ];

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        content: json['content'],
        projectId: json['project_id'],
        sectionId: json['section_id'] ?? '',
        order: json['order'],
        priority: json['priority'],
        commentCount: json['comment_count'],
        url: json['url'],
        due: Due.fromJson(json['due'] ?? {}),
        labels: List<String>.from(json['labels']),
        isCompleted: json['is_completed'],
        creatorId: json['creator_id'],
        assignerId: json['assigner_id'] ?? '',
        assigneeId: json['assignee_id'] ?? '',
        createdAt: DateTime.parse(json['created_at']),
        description: json['description'],
        duration: TaskDuration.fromJson(json['duration'] ?? {}),
        parentId: json['parent_id'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'project_id': projectId,
        'section_id': sectionId,
        'order': order,
        'priority': priority,
        'comment_count': commentCount,
        'url': url,
        'due': due!.toJson(),
        'labels': labels,
        'is_completed': isCompleted,
        'creator_id': creatorId,
        'assigner_id': assignerId,
        'assignee_id': assigneeId,
        'created_at': createdAt.toIso8601String(),
        'description': description,
        'duration': duration!.toJson(),
        'parent_id': parentId,
      };

  Task copyWith({
    String? id,
    String? content,
    String? projectId,
    String? sectionId,
    int? order,
    int? priority,
    int? commentCount,
    String? url,
    Due? due,
    List<String>? labels,
    bool? isCompleted,
    String? creatorId,
    String? assignerId,
    String? assigneeId,
    DateTime? createdAt,
    String? description,
    TaskDuration? duration,
    String? parentId,
  }) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      commentCount: commentCount ?? this.commentCount,
      url: url ?? this.url,
      due: due ?? this.due,
      labels: labels ?? this.labels,
      isCompleted: isCompleted ?? this.isCompleted,
      creatorId: creatorId ?? this.creatorId,
      assignerId: assignerId ?? this.assignerId,
      assigneeId: assigneeId ?? this.assigneeId,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, content: $content, projectId: $projectId, sectionId: $sectionId, order: $order, priority: $priority, commentCount: $commentCount, url: $url, due: $due, labels: $labels, isCompleted: $isCompleted, creatorId: $creatorId, assignerId: $assignerId, assigneeId: $assigneeId, createdAt: $createdAt, description: $description, duration: $duration, parentId: $parentId)';
  }

  @override
  bool get stringify => true;

  static final empty = Task(
    id: '',
    content: '',
    projectId: '',
    sectionId: '',
    order: 0,
    priority: 0,
    commentCount: 0,
    url: '',
    due: Due.empty,
    labels: [],
    isCompleted: false,
    creatorId: '',
    assignerId: '',
    assigneeId: '',
    createdAt: DateTime.now(),
    description: '',
    duration: TaskDuration.empty,
    parentId: '',
  );
}

class Due extends Equatable {
  const Due({
    required this.date,
    required this.isRecurring,
    required this.string,
    required this.lang,
  });

  final String date;
  final bool isRecurring;
  final String string;
  final String lang;

  List<Object> get props => [date, isRecurring, string, lang];

  factory Due.fromJson(Map<String, dynamic> json) => Due(
        date: json['date'] ?? '',
        isRecurring: json['is_recurring'] ?? false,
        string: json['string'] ?? '',
        lang: json['lang'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'is_recurring': isRecurring,
        'string': string,
        'lang': lang,
      };

  Due copyWith({
    String? date,
    bool? isRecurring,
    String? string,
    String? lang,
  }) {
    return Due(
      date: date ?? this.date,
      isRecurring: isRecurring ?? this.isRecurring,
      string: string ?? this.string,
      lang: lang ?? this.lang,
    );
  }

  @override
  String toString() {
    return 'Due(date: $date, isRecurring: $isRecurring, string: $string, lang: $lang)';
  }

  @override
  bool get stringify => true;

  static final empty = Due(
    date: '',
    isRecurring: false,
    string: '',
    lang: '',
  );
}

class TaskDuration extends Equatable {
  const TaskDuration({
    required this.amount,
    required this.unit,
  });

  final int amount;
  final String unit;

  List<Object> get props => [amount, unit];

  factory TaskDuration.fromJson(Map<String, dynamic> json) => TaskDuration(
        amount: json['amount'] ?? 0,
        unit: json['unit'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'unit': unit,
      };

  TaskDuration copyWith({
    int? amount,
    String? unit,
  }) {
    return TaskDuration(
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  @override
  String toString() {
    return 'Duration(amount: $amount, unit: $unit)';
  }

  @override
  bool get stringify => true;

  static const empty = TaskDuration(amount: 0, unit: '');
}

class TaskResponse extends Equatable {
  const TaskResponse({
    required this.tasks,
  });

  final List<Task> tasks;

  List<Object> get props => [tasks];

  factory TaskResponse.fromJson(List<dynamic> json) {
    return TaskResponse(
      tasks: List<Task>.from(json.map((x) => Task.fromJson(x))),
    );
  }

  @override
  String toString() => 'TaskResponse(tasks: $tasks)';

  @override
  bool get stringify => true;
}

class SingleTaskResponse extends Equatable {
  const SingleTaskResponse({
    required this.task,
  });

  final Task task;

  List<Object> get props => [task];

  factory SingleTaskResponse.fromJson(Map<String, dynamic> json) {
    return SingleTaskResponse(
      task: Task.fromJson(json),
    );
  }

  @override
  String toString() => 'SingleTaskResponse(task: $task)';

  @override
  bool get stringify => true;
}

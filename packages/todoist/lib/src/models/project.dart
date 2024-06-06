import 'package:equatable/equatable.dart';

class Project extends Equatable {
  const Project({
    required this.id,
    this.parentId,
    required this.order,
    required this.color,
    required this.name,
    required this.commentCount,
    required this.isShared,
    required this.isFavorite,
    required this.isInboxProject,
    required this.isTeamInbox,
    required this.url,
    required this.viewStyle,
  });

  final String id;
  final int? parentId;
  final int order;
  final String color;
  final String name;
  final int commentCount;
  final bool isShared;
  final bool isFavorite;
  final bool isInboxProject;
  final bool isTeamInbox;
  final String url;
  final String viewStyle;

  @override
  List<Object> get props => [
        id,
        parentId ?? 0,
        order,
        color,
        name,
        commentCount,
        isShared,
        isFavorite,
        isInboxProject,
        isTeamInbox,
        url,
        viewStyle,
      ];

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'].toString(),
      parentId: json['parent_id'] ?? 0,
      order: json['order'] as int,
      color: json['color'] as String,
      name: json['name'] as String,
      commentCount: json['comment_count'] as int,
      isShared: json['is_shared'] as bool,
      isFavorite: json['is_favorite'] as bool,
      isInboxProject: json['is_inbox_project'] as bool,
      isTeamInbox: json['is_team_inbox'] as bool,
      url: json['url'] as String,
      viewStyle: json['view_style'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'order': order,
      'color': color,
      'name': name,
      'comment_count': commentCount,
      'is_shared': isShared,
      'is_favorite': isFavorite,
      'is_inbox_project': isInboxProject,
      'is_team_inbox': isTeamInbox,
      'url': url,
      'view_style': viewStyle,
    };
  }

  Project copyWith({
    String? id,
    int? parentId,
    int? order,
    String? color,
    String? name,
    int? commentCount,
    bool? isShared,
    bool? isFavorite,
    bool? isInboxProject,
    bool? isTeamInbox,
    String? url,
    String? viewStyle,
  }) {
    return Project(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      order: order ?? this.order,
      color: color ?? this.color,
      name: name ?? this.name,
      commentCount: commentCount ?? this.commentCount,
      isShared: isShared ?? this.isShared,
      isFavorite: isFavorite ?? this.isFavorite,
      isInboxProject: isInboxProject ?? this.isInboxProject,
      isTeamInbox: isTeamInbox ?? this.isTeamInbox,
      url: url ?? this.url,
      viewStyle: viewStyle ?? this.viewStyle,
    );
  }

  @override
  String toString() {
    return 'Project { id: $id, parent_id: $parentId, order: $order, color: $color, name: $name, comment_count: $commentCount, is_shared: $isShared, is_favorite: $isFavorite, is_inbox_project: $isInboxProject, is_team_inbox: $isTeamInbox, url: $url, view_style: $viewStyle }';
  }

  @override
  bool get stringify => true;

  static const empty = Project(
      id: '',
      parentId: 0,
      order: 0,
      color: '',
      name: '',
      commentCount: 0,
      isShared: false,
      isFavorite: false,
      isInboxProject: false,
      isTeamInbox: false,
      url: '',
      viewStyle: '');
}

class ProjectResponse extends Equatable {
  ProjectResponse({required this.projects});

  final List<Project> projects;

  factory ProjectResponse.fromJson(List<dynamic> json) {
    return ProjectResponse(
      projects: json.map((e) => Project.fromJson(e)).toList(),
    );
  }

  @override
  List<Object> get props => [projects];
}

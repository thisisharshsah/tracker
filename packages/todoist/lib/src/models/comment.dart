class Comment {
  Comment({
    required this.content,
    required this.id,
    required this.postedAt,
    this.projectId,
    this.taskId,
    this.attachment,
  });

  String content;
  String id;
  String postedAt;
  String? projectId;
  String? taskId;
  Attachment? attachment;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        content: json['content'],
        id: json['id'],
        postedAt: json['posted_at'],
        projectId: json['project_id'],
        taskId: json['task_id'],
        attachment: json['attachment'] == null
            ? null
            : Attachment.fromJson(json['attachment']),
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'id': id,
        'posted_at': postedAt,
        'project_id': projectId,
        'task_id': taskId,
        'attachment': attachment?.toJson(),
      };
}

class Attachment {
  Attachment({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.resourceType,
  });

  String fileName;
  String fileType;
  String fileUrl;
  String resourceType;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileName: json['file_name'],
        fileType: json['file_type'],
        fileUrl: json['file_url'],
        resourceType: json['resource_type'],
      );

  Map<String, dynamic> toJson() => {
        'file_name': fileName,
        'file_type': fileType,
        'file_url': fileUrl,
        'resource_type': resourceType,
      };
}

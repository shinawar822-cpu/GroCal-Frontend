class TaskModel {
  final String id, title, description, taskType, platform, niche, taskLink, thumbnail, creatorId, creatorName;
  final String? creatorImage;
  final int reward, verificationReward, participantsNeeded, participantsCompleted;
  final bool isVerified;
  final DateTime createdAt;

  TaskModel({required this.id, required this.title, required this.description, required this.taskType, required this.platform, required this.niche, required this.taskLink, required this.thumbnail,
    required this.reward, this.verificationReward = 3, required this.participantsNeeded, this.participantsCompleted = 0, required this.creatorId, required this.creatorName, this.creatorImage,
    this.isVerified = false, required this.createdAt});

  int get totalCost => (reward + verificationReward) * participantsNeeded;
  int get remainingSlots => participantsNeeded - participantsCompleted;
  double get completionPercentage => participantsNeeded == 0 ? 0 : (participantsCompleted / participantsNeeded) * 100;

  factory TaskModel.fromJson(Map<String, dynamic> j) => TaskModel(
    id: j['id'] ?? '', title: j['title'] ?? '', description: j['description'] ?? '', taskType: j['task_type'] ?? '', platform: j['platform'] ?? '', niche: j['niche'] ?? '',
    taskLink: j['task_link'] ?? '', thumbnail: j['thumbnail'] ?? '', reward: j['reward'] ?? 0, verificationReward: j['verification_reward'] ?? 3, participantsNeeded: j['participants_needed'] ?? 0,
    participantsCompleted: j['participants_completed'] ?? 0, creatorId: j['creator_id'] ?? '', creatorName: j['creator_name'] ?? '', creatorImage: j['creator_image'],
    isVerified: j['is_verified'] ?? false, createdAt: DateTime.parse(j['created_at'] ?? DateTime.now().toIso8601String()));
}

class TaskProofModel {
  final String id, taskId, userId, userName, submittedLink, status;
  final String? userImage;
  final DateTime submittedAt;

  TaskProofModel({required this.id, required this.taskId, required this.userId, required this.userName, required this.submittedLink, this.status = 'pending', this.userImage, required this.submittedAt});
}

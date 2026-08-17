class UserAssets {
  final String? iconUri;
  final String? supporterIcon;
  final String? imageUri;

  UserAssets(this.iconUri, this.supporterIcon, this.imageUri);

  factory UserAssets.fromJson(Map<String, dynamic> json) {
    return UserAssets(
      (json["icon"] as Map<String, dynamic>?)?["uri"]?.toString(),
      json["supporterIcon"]?.toString(),
      (json["image"] as Map<String, dynamic>?)?["uri"]?.toString(),
    );
  }
}

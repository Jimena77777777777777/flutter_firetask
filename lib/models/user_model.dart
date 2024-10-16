class UserModel {
  String? id;
  String fullName;
  String email;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
      };
}
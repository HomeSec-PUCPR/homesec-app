class AppUserModel {
  final String name;
  final String birthdate;
  final String email;

  AppUserModel({
    required this.name,
    required this.birthdate,
    required this.email,
  });

  factory AppUserModel.empty() {
    return AppUserModel(
      name: "",
      birthdate: "",
      email: "",
    );
  }

  factory AppUserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AppUserModel.empty();
    return AppUserModel(
      name: json['Name'] ?? "",
      birthdate: json['Birthdate'] ?? "",
      email: json['Email'] ?? "",
    );
  }
}

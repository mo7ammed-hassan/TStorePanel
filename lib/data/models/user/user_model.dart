import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/formatters/formatter.dart';

class UserModel {
  String? userID;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String phone;
  final AppRole role;
  final String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.userID,
    this.firstName = '',
    this.lastName = '',
    required this.email,
    this.userName = '',
    this.phone = '',
    this.profilePicture = '',
    this.createdAt,
    this.updatedAt,
    this.role = AppRole.user,
  });

  /// Helper method
  String get fullName => '$firstName $lastName';
  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phone);

  /// Static Function to create an empty user model
  static UserModel empty() => UserModel(email: '');
  // TO JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'username': userName,
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
      'role': role.name, // user or admin
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // FROM JSON
  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return UserModel(
        userID: document.id,
        firstName:
            data.containsKey('firstName')
                ? data['firstName'] as String? ?? ''
                : '',
        lastName:
            data.containsKey('lastName')
                ? data['lastName'] as String? ?? ''
                : '',
        userName:
            data.containsKey('username')
                ? data['username'] as String? ?? ''
                : '',
        email: data.containsKey('email') ? data['email'] as String? ?? '' : '',
        phone: data.containsKey('phone') ? data['phone'] as String? ?? '' : '',
        role:
            data.containsKey('role')
                ? ((data['role'] ?? AppRole.user) == AppRole.admin.name)
                    ? AppRole.admin
                    : AppRole.user
                : AppRole.user,
        profilePicture:
            data.containsKey('profilePicture')
                ? data['profilePicture'] as String? ?? ''
                : '',

        createdAt:
            data.containsKey('createdAt')
                ? data['createdAt']?.toDate() ?? DateTime.now()
                : DateTime.now(),
        updatedAt:
            data.containsKey('updatedAt')
                ? data['updatedAt']?.toDate() ?? DateTime.now()
                : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}

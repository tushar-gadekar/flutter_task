class UserModel {
  String? id;
  String firstName;
  String dob;
  String mobile;

  UserModel({this.id, required this.firstName, required this.dob, required this.mobile});

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'dob': dob,
        'mobile': mobile,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        firstName: map['firstName'],
        dob: map['dob'],
        mobile: map['mobile'],
      );
}
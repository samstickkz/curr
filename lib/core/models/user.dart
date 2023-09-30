class User {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  bool? isActive;
  bool? emailConfirmed;
  String? phoneNumber;
  String? imageUrl;

  User(
      {this.id,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.isActive,
        this.emailConfirmed,
        this.phoneNumber,
        this.imageUrl,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    isActive = json['isActive'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['emailConfirmed'] = this.emailConfirmed;
    data['phoneNumber'] = this.phoneNumber;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class User {
  String displayName;
  String phoneNumber;
  String email;
  String uid;

  User({
    this.displayName = '',
    this.phoneNumber = '',
    this.email = '',
    this.uid = '',
  });

  User.fromJSON(Map<String, dynamic> json)
      : this(
          displayName: json['displayName'],
          phoneNumber: json['phoneNumber'],
          email: json['email'],
          uid: json['uid'],
        );

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = Map<String, dynamic>();

    json['displayName'] = displayName;
    json['phoneNumber'] = phoneNumber;
    json['email'] = email;
    json['uid'] = uid;

    return json;
  }
}

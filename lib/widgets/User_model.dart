class UserModel{
  String? firstName;
  String? lastName;
  String? email;
  String? uid;
  String? role;
  String? imageUrl;
  String? phoneNumber;
  String? location;
  String? displayName;


  UserModel({this.firstName,this.lastName,  this.uid,this.email,this.role,this.imageUrl,this.phoneNumber,this.location,this.displayName});

  factory UserModel.fromMap(map){
    return UserModel(firstName: map['firstName'],lastName: map['lastName'],uid: map['uid'],email: map['email'],role:map['Role'],imageUrl: map['imageUrl'],phoneNumber: map['phoneNumber'],location: map['location'],displayName: map['displayName']);
  }

  Map<String, dynamic>toMap(){
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email' : email,
      'uid': uid,
      'role':role,
      'location': location,
      'imageUrl':imageUrl,
      'phoneNumber':phoneNumber,
      'displayName':displayName
    };
  }
}
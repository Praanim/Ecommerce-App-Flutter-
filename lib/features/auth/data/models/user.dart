class UserModel{
  final String? email;
  final String? password;
  final String? uid;

  const UserModel({
    this.email,
    this.password,
    this.uid
  });

  factory UserModel.fromJson(Map<String,dynamic> map){
    return UserModel(
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'email': email,
      'password': password
    };
  }
}
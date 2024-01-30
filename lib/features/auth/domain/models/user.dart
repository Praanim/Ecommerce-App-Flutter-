class User{
  final String? email;
  final String? password;

  const User({
    this.email,
    this.password
  });

  factory User.fromJson(Map<String,dynamic> map){
    return User(
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
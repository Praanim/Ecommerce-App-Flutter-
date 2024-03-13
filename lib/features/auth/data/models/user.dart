class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? state;
  final String? password;

  const UserModel(
      {this.id,
      this.fullName,
      this.email,
      this.address,
      this.city,
      this.state,
      this.password});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      state: map['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? address,
    String? city,
    String? state,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      password: password ?? this.password,
    );
  }
}

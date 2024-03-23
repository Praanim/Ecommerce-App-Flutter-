class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final AddressModel? address;
  final String? password;
  final String? mobile;
  final String? profileImage;

  const UserModel(
      {this.id,
      this.fullName,
      this.email,
      this.address,
      this.password,
      this.mobile,
      this.profileImage});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      mobile: map['mobile'],
      profileImage: map['profileImage'],
      address:
          map['address'] != null ? AddressModel.fromJson(map['address']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'profileImage': profileImage,
      'address': address
    };
  }

  UserModel copyWith(
      {String? id,
      String? fullName,
      String? email,
      AddressModel? address,
      String? password,
      String? mobile,
      String? profileImage}) {
    return UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        address: address ?? this.address,
        password: password ?? this.password,
        mobile: mobile ?? this.mobile,
        profileImage: profileImage ?? this.profileImage);
  }
}

class AddressModel {
  final String? address;
  final String? city;
  final String? state;

  const AddressModel({
    this.address,
    this.city,
    this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      address: map['address'],
      city: map['city'],
      state: map['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
    };
  }

  AddressModel copyWith({
    String? address,
    String? city,
    String? state,
  }) {
    return AddressModel(
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}

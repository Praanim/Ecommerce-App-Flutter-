class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final AddressModel? address;
  final String? password;

  const UserModel({
    this.id,
    this.fullName,
    this.email,
    this.address,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      address: AddressModel.fromJson(map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'address': address?.address,
      'city': address?.city,
      'state': address?.state,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    AddressModel? address,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      password: password ?? this.password,
    );
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

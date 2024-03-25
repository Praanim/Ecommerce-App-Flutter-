import 'package:nattt_bazaar/features/auth/data/models/user.dart';
import 'package:nattt_bazaar/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  final AuthRepository authRepository;

  UserNotifier(this.authRepository) : super(null);

  ///cachedUser Details
  UserModel? cachedUser;

  /// sets the user details so that it can be used throughout the app
  void setUserDetails(UserModel userModel) {
    cachedUser = userModel;
    state = cachedUser;
  }

  /// clear up user details to null
  void clearUpUserDetails() {
    cachedUser = null;
    state = null;
  }

  ///update user Details
  Future<String> updateUserDetails(
      {String? profileImage,
      AddressModel? addressModel,
      String? mobile}) async {
    //user model
    final userModel = state!.copyWith(
      address: addressModel,
      mobile: mobile,
      profileImage: profileImage,
    );

    late String message;

    //either response
    final eitherResponse =
        await authRepository.updateUser(userModel: userModel);
    state = eitherResponse.fold((appException) {
      message = "Couldn't upadte user details";
      return cachedUser!;
    }, (userModel) {
      message = "Successfully updated user details";
      return userModel;
    });

    return message;
  }
}

import 'package:nattt_bazaar/features/auth/data/models/user.dart';
import 'package:nattt_bazaar/features/auth/domain/providers/auth_provider.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/state/auth_state.dart';
import 'package:nattt_bazaar/features/auth/presentation/providers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///auth notifier provider
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

final getUserByEmailFutureProvider =
    FutureProvider.family<UserModel?, String>((ref, email) async {
  final authRepo = ref.watch(authRepositoryProvider);

  final eitherResponse = await authRepo.getUserByEmail(email: email);

  return eitherResponse.fold((appException) => null, (userModel) {
    //initializing the user Data provider.
    ref.read(userDataProvider.notifier).setUserDetails(userModel);
    return userModel;
  });
});

///This provider is for getting logged in user Details throughout the app.
final userDataProvider = StateNotifierProvider<UserNotifier, UserModel?>(
    (ref) => UserNotifier(ref.watch(authRepositoryProvider)));

///password visibilityProvider
final passwordVisibilityProvider =
    StateProvider.autoDispose<bool>((ref) => false);

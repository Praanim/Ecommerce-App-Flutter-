import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/domain/providers/auth_provider.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
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
    ref.read(userDataProvider.notifier).state = userModel;
    return userModel;
  });
});

///This provider is for getting logged in user Details throughout the app.
final userDataProvider = StateProvider<UserModel?>((ref) => null);

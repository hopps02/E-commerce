import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/domain/usecase/update_profile_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileState extends Equatable {
  final String name;
  final String phone;

  const ProfileState({this.name = '', this.phone = ''});

  /// Avatar circle letter; falls back to the phone's last digit-less blank.
  String get initial => name.trim().isEmpty ? '' : name.trim()[0];

  ProfileState copyWith({String? name, String? phone}) {
    return ProfileState(name: name ?? this.name, phone: phone ?? this.phone);
  }

  @override
  List<Object?> get props => [name, phone];
}

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    Future.microtask(load);
    return const ProfileState();
  }

  /// Re-fetches the customer profile. Returns true on success.
  Future<bool> load() async {
    final result = await DI().getProfileUseCase.execute(null);
    return result.fold(
      (_) => false, // The header keeps its placeholders on failure.
      (profile) {
        state = ProfileState(
          name: profile.name ?? 'User${profile.id}',
          phone: profile.phone,
        );
        return true;
      },
    );
  }

  /// Pull-to-refresh handler: reloads the profile and drives the refresh
  /// controller's completed/failed state for the caller.
  Future<void> refresh(RefreshController controller) async {
    final ok = await load();
    ok ? controller.refreshCompleted() : controller.refreshFailed();
  }

  /// Updates the customer's display name. Returns true when saved.
  Future<bool> updateName(String name) async {
    DI().loadingService.show();
    final result = await DI().updateProfileUseCase.execute(
      UpdateProfileParams(name: name),
    );
    DI().loadingService.hide();

    return result.fold(
      (failure) {
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        return false;
      },
      (profile) {
        state = ProfileState(name: profile.name ?? '', phone: profile.phone);
        return true;
      },
    );
  }

  /// Soft-deletes the account server-side then tears the session down.
  /// Returns true when the caller should navigate back to auth.
  Future<bool> deleteAccount() async {
    DI().loadingService.show();
    final result = await DI().deleteAccountUseCase.execute(null);
    DI().loadingService.hide();

    return result.fold(
      (failure) {
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        return false;
      },
      (_) async {
        // The backend already revoked the token; only local state remains.
        await DI().sessionService.clearLocal();
        return true;
      },
    );
  }
}

final profileController =
    NotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
      ProfileNotifier.new,
    );

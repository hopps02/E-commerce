import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';

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

  Future<void> load() async {
    final result = await DI().customerRepository.profile();
    result.fold(
      (_) {}, // The header keeps its placeholders on failure.
      (profile) =>
          state = ProfileState(name: profile.name ?? '', phone: profile.phone),
    );
  }

  /// Updates the customer's display name. Returns true when saved.
  Future<bool> updateName(String name) async {
    DI().loadingService.show();
    final result = await DI().customerRepository.updateProfile(name: name);
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
    final result = await DI().customerRepository.deleteAccount();
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

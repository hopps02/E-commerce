import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:store/presentation/common/login_required_bottom_sheet.dart';
import 'package:store/presentation/res/router/app_router.dart';

final isGuestProvider = FutureProvider.autoDispose<bool>(
  (ref) => DI().sessionService.isGuest,
);

/// Silently establishes an anonymous guest session so the storefront opens
/// without a login screen. Returns true when the guest token was issued and
/// stored; false (e.g. offline) lets the caller fall back to the auth screen.
Future<bool> enterAsGuest() async {
  final result = await DI().guestLoginUseCase.execute(null);
  final session = result.fold((_) => null, (s) => s);
  if (session == null) return false;
  await DI().sessionService.establishGuest(session.accessToken);
  return true;
}

Future<bool> requireLogin(BuildContext context, WidgetRef ref) async {
  final isGuest = await ref.read(isGuestProvider.future);
  if (!isGuest) return true;
  if (!context.mounted) return false;

  final goToAuth = await LoginRequiredBottomSheet.show(context);
  if (goToAuth == true && context.mounted) {
    ref.invalidate(isGuestProvider);
    context.goNamed(Routes.auth);
  }
  return false;
}

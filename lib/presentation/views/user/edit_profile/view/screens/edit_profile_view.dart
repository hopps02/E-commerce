import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/user/edit_profile/view/widgets/edit_profile_app_bar.dart';
import 'package:store/presentation/views/user/edit_profile/view/widgets/edit_profile_form.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.white,
      body: ResponsiveConstrained(
        maxWidth: 550,
        child: Column(
          children: [
            // Status bar space
            SizedBox(height: context.topSafeAreaPadding),

            // App Bar
            const EditProfileAppBar().premiumAppear(index: 0),

            // Thin divider
            Container(
              height: 6.h,
              color: ColorM.gray150,
            ).premiumAppear(index: 1),

            // Scrollable body
            Expanded(
              child: SingleChildScrollView(
                child: const EditProfileForm().premiumAppear(index: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

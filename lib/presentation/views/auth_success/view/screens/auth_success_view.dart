import 'package:flutter/material.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/auth_success/view/widgets/body.dart';
import 'package:jar/presentation/views/auth_success/view/widgets/loading.dart';

class AuthSuccessView extends StatelessWidget {
  const AuthSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            Loading(),

            const Spacer(),

            Body(),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jar/app/enums/enums.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/auth_success/view/widgets/body.dart';
import 'package:jar/presentation/views/auth_success/view/widgets/loading.dart';


class AuthSuccessArgs{
  final SuccessViewType successViewType;
  const AuthSuccessArgs({required this.successViewType});
}

class AuthSuccessView extends StatelessWidget {
  final AuthSuccessArgs args;
  const AuthSuccessView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.greenPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            Loading(),

            const Spacer(),

            Body(
              successViewType: args.successViewType,
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

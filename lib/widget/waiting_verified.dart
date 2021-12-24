import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';

class WaitingVerified extends StatelessWidget {
  const WaitingVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Text("Movier"),
            Text("가입을 축하드립니다! 이메일 인증 후 이용하실 수 있습니다"),
         //   TextButton(onPressed:AuthenticationState, child: Text("돌아가기"))
          ],
        )
    );
  }
}
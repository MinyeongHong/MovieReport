import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("비밀번호찾기"),
      ),
    );
  }
}

import 'package:MovieReviewApp/page/auth_forgot_password.dart';
import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;
  Login({required this.toggleScreen});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _EmailforNewpsdController;

  final _formkey=GlobalKey<FormState>();
  final _formkey2=GlobalKey<FormState>();

  @override void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _EmailforNewpsdController= TextEditingController();
    super.initState();
  }

  @override void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _EmailforNewpsdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginprovider =Provider.of<AuthServices>(context);
    String email ='';
    return Scaffold(
      backgroundColor: Color(0xFF1D1E21),
      drawerScrimColor: Colors.white,
        body:SafeArea(
          child: SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 80,),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Color(0xFFF5F5F1)),
                    child: Text("Movier"),),
                  SizedBox(height: 140,),
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _emailController,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Email can't be empty";
                              }
                              return null;
                            },
                          decoration: InputDecoration(
                            fillColor: Color(0x50FFFFFF),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "이메일을 입력하세요",
                            prefixIcon:Icon(Icons.mail,color: Colors.white,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          validator: (String? value) {
                            if (value != null && value.length < 6) {
                              return "Password can't be less than 6";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            focusColor:Colors.white,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "비밀번호를 입력하세요",
                              prefixIcon:Icon(Icons.vpn_key,color: Colors.white,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        MaterialButton(
                          onPressed: () async {
                            if(_formkey.currentState!.validate()){
                              print("Email: ${_emailController.text}");
                              print("Password: ${_passwordController.text}");
                              await loginprovider.login(_emailController.text.trim(),_passwordController.text.trim());
                              if(FirebaseAuth.instance.currentUser!=null){
                                if(FirebaseAuth.instance.currentUser!.emailVerified==true){print("로그인 성공");}
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: const Text("이메일 인증을 완료해주세요!"),
                                    action: SnackBarAction(
                                      label: '재전송하기',
                                      onPressed: () {
                                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                        // Code to execute.
                                      },
                                    ),
                                  ));
                                }
                              }

                            }
                          },
                          height: 60,
                          minWidth: loginprovider.isLoading? null :double.infinity,
                          color: Color(0xFFE50914),
                          textColor: Color(0xFFF5F5F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: loginprovider.isLoading
                          ? CircularProgressIndicator(color: Colors.white,)
                          : Text(
                            "로그인",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("계정이 없나요?",style:TextStyle(color: Colors.white),),
                      TextButton(onPressed: (){
                        widget.toggleScreen();
                      },
                          child: Text("회원가입하기",style: TextStyle(color:Color(0xFFE50914) ),)
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder:(dialog_context){
                                return Form(
                                  key: _formkey2,
                                  child: AlertDialog(
                                    backgroundColor: Color(0xFFA2A7BB),
                                    title:Text("비밀번호 재설정",style: TextStyle(color: Colors.black,),),
                                    content:TextFormField(
                                      controller: _EmailforNewpsdController,
                                      validator: (String? value) {
                                        if (value != null) {
                                          if (value.isEmpty)
                                            return '이메일을 입력하세요.';
                                          else {
                                            Pattern pattern =
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            RegExp regExp = new RegExp(pattern.toString());
                                            if (!regExp.hasMatch(value)) {
                                              return '잘못된 이메일 형식입니다.';
                                            }
                                          }
                                        } else
                                          return null;
                                      },
                                      onChanged: (value){
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      decoration: InputDecoration(hintText: "이메일을 입력하세요."),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        child:Text("전송",style: TextStyle(color: Colors.black),),
                                        onPressed:() async {
                                          if (_formkey2.currentState!.validate()) {
                                              await loginprovider.sendPasswordResetEmail(_EmailforNewpsdController.text);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: const Text("비밀번호 재설정을 위한 이메일이 전송되었습니다."),
                                              ));
                                              Navigator.pop(dialog_context);
                                            }
                                          },)
                                    ],
                                  ),
                                );
                              }
                            );
                          },
                          child: Text("비밀번호 찾기",style: TextStyle(color:Colors.white ),)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}


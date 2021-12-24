import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final _formkey=GlobalKey<FormState>();

  @override void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginprovider =Provider.of<AuthServices>(context);

    return Scaffold(
      backgroundColor: Color(0xFF1D1E21),
      drawerScrimColor: Colors.white,
        body:SafeArea(
          child: SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 150,),
                    DefaultTextStyle(
                      style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Color(0xFFF5F5F1)),
                      child: Text("Movier"),),
                    SizedBox(height: 120,),
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
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "비밀번호를 입력하세요",
                          prefixIcon:Icon(Icons.vpn_key,color: Colors.white,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(height: 30,),
                    MaterialButton(
                      onPressed: () async {
                        if(_formkey.currentState!.validate()){
                          print("Email: ${_emailController.text}");
                          print("Password: ${_passwordController.text}");
                          await loginprovider.login(_emailController.text.trim(),_passwordController.text.trim());
                          if(FirebaseAuth.instance.currentUser!.emailVerified==false){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text("이메일 인증을 완료해주세요!"),
                            ));
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
                      ? CircularProgressIndicator()
                      : Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


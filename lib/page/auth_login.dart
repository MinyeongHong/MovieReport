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

  bool _obscureText = true;

  void _toggle_pswd() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background2.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
       // backgroundColor: Color(0xFF1D1E21),
        drawerScrimColor: Colors.white,
          body:SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 80,),
                    Text("Movier!",
                      style: TextStyle(letterSpacing: 4,fontSize: 60,fontWeight: FontWeight.bold,color: Color(0xFFF5F5F1)),),
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
                                if (value != null) {
                                  if (value.isEmpty) return "이메일을 입력해주세요";
                                  else {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regExp = new RegExp(pattern.toString());
                                    if (!regExp.hasMatch(value)) {
                                      return '잘못된 이메일 형식입니다.';
                                    }
                                  }
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
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)
                              ),

                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _passwordController,
                            validator: (String? value) {
                              if (value != null && value.length < 6) {
                                return "비밀번호는 6자리 이상입니다";
                              }
                              return null;
                            },
                            obscureText:  _obscureText,
                            decoration: InputDecoration(
                              focusColor:Colors.white,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "비밀번호를 입력하세요",
                                prefixIcon:Icon(Icons.vpn_key,color: Colors.white,),
                                suffixIcon: InkWell(
                                  onTap: _toggle_pswd,
                                  child: Icon(
                                    _obscureText
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)
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
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: const Text("로그인에 실패하였습니다. \n이메일과 비밀번호를 다시한번 확인해주세요",style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.black,

                                  ));
                                }

                              }
                            },
                            height: 60,
                            minWidth: loginprovider.isLoading? null :double.infinity,
                            color: Color(0xFFAE001F),
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
                            child: Text("회원가입하기",style: TextStyle(color:Color(0xFFAE001F) ),)
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                      backgroundColor: Colors.grey[900],
                                      title:Text("비밀번호 재설정",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      contentPadding: EdgeInsets.all(20.0),
                                      content:Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Divider(
                                            color: Colors.grey[200],
                                            height: 4.0,
                                          ),
                                            SizedBox(height: 15,),
                                            Text("입력하신 이메일로 전송된 링크를 통해 비밀번호를 재설정하실 수 있습니다.",style: TextStyle(color: Colors.white,fontSize: 13),),
                                            SizedBox(height: 3,),
                                            TextFormField(
                                              cursorColor: Colors.white,
                                              autofocus: true,
                                              style: TextStyle(color: Colors.white),
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
                                              decoration: InputDecoration(
                                                hintText: "이메일을 입력하세요.",
                                                hintStyle: TextStyle(color: Colors.white10),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Color(0xFFAE001F)),
                                                padding:MaterialStateProperty.all(const EdgeInsets.fromLTRB(20, 10, 20, 10)),),
                                          child:Text("전송",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
                                      ),

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
      ),
    );
  }
}


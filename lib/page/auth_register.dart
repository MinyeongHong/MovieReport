import 'package:MovieReviewApp/widget/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class register extends StatefulWidget {
  final Function toggleScreen;
  register({required this.toggleScreen});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordController2;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordController2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "Movier",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Color(0xFF1D1E21),
      drawerScrimColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("회원가입",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailController,
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
                    decoration: InputDecoration(
                        fillColor: Color(0x50FFFFFF),
                        hintText: "이메일을 입력하세요",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)
                    ),),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    validator: (String? value) {
                      if (value != null && value.length < 6) {
                        return "6자리 이상의 비밀번호를 입력해주세요";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Color(0x50FFFFFF),
                        hintText: "비밀번호를 입력하세요",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController2,
                    validator: (String? value) {
                      if (value != null){
                         if( _passwordController.text != _passwordController2.text) {
                        print(_passwordController.text);
                        print(_passwordController2.text);
                        return "비밀번호가 일치하지 않습니다";
                      }else return null;
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Color(0x50FFFFFF),
                        hintText: "비밀번호를 재입력하세요",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
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
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if(_passwordController.text == _passwordController2.text) {
                          await loginprovider.register(
                              _emailController.text.trim(),
                              _passwordController.text.trim());
                          widget.toggleScreen();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text("가입이 완료되었습니다. 이메일 인증 완료 후 이용가능합니다"),
                          ));
                        }
                      }
                    },
                    height: 60,
                    minWidth: loginprovider.isLoading ? null : double.infinity,
                    color: Color(0xFFE50914),
                    textColor: Color(0xFFF5F5F1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: loginprovider.isLoading
                        ? Center(child: CircularProgressIndicator(color: Colors.white,))
                        : Text(
                            "가입하기",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "계정이 있나요?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            widget.toggleScreen();
                          },
                          child: Text(
                            "로그인",
                            style: TextStyle(color: Color(0xFFE50914)),
                          ))
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

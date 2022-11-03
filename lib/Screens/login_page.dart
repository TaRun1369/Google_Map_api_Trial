import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:screens_for_touristapp/auth/auth.dart';
// late String username = "USERNAME" ;
// late String password ;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
      isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(gradient:mainGradient(context)),
        child: Column(

          children: [
            //image
            Expanded(
              flex: 5,
              child: Container(
                child: Image.asset(isLogin ?  'assets/login_page/login_page_image.png' : 'assets/login_page/register_page_img.png'),
              ),
            ),

            Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                      child: Text(isLogin ? 'LOGIN' : 'REGISTER',style: const TextStyle(fontSize: 40),)
                  ),
                )),
            const SizedBox(height: 20),
            // Container(
            //   width: 240,
            //   height: 50,
            //   color: Colors.greenAccent[1000],
            //   child: TextField(
            //
            //     onTap: () {
            //       username = "";
            //     },
            //     cursorColor: Colors.purple,
            //     onChanged: (text){
            //       username = text;
            //     },
            //   ),
            // ),
            _entryField('email', _controllerEmail),
            Container(child: const SizedBox(height:30)),


            // Container(
            //   width: 240,
            //   height: 50,
            //   color: Colors.greenAccent[1250],
            //   child: TextField(
            //     onChanged: (text){
            //       password = text;
            //     },
            //   ),
            // ),
            _entryField('password', _controllerPassword),
            Container(child: SizedBox(height:30)),
            // FloatingActionButton.extended(
            //     label: Text("kar n lavde login"),
            //     onPressed: null),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
            Container(child: SizedBox(height:60))
          ],
        ),
      ),
    );
  }
}

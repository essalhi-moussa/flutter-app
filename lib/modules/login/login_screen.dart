// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  //const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Text(
        "Login",
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 40.0,),
                  defaultFormField(
                    controller: emailController,
                    label: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'email adress  must not be empty';
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 20.0,),
              defaultFormField(
                  controller: passwordController,
                  label: 'Password',
                  prefix: Icons.lock,
                  suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                  type: TextInputType.visiblePassword,
                  isPassword: isPassword,
                  suffixPressd: (){
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  validate: (value){
                    if(value!.isEmpty){
                      return 'password is too shor';
                    }
                    return null;
                  }
              ),
                  SizedBox(height: 20.0,),
                  defaultButton(
                    text: 'login',
                    function: (){
                      if(formKey.currentState!.validate()){
                        print(emailController.text);
                        print(passwordController.text);
                      }

                    },
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?'
                      ),
                      TextButton(
                          onPressed: (){},
                          child: Text(
                            'Register Now'
                          ))
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

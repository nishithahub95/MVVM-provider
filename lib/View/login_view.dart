import 'package:flutter/material.dart';
import 'package:provider_mvvm/Resources/components/round_button.dart';
import 'package:provider_mvvm/Utils/Routes/routes_name.dart';
import 'package:provider_mvvm/Utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/ViewModel/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode=FocusNode();
  FocusNode passwordFocusNode=FocusNode();
  ValueNotifier<bool> _obsequrePassword=ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsequrePassword.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height * 1 ;
    final authViewModel=Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black)),
                  prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon( Icons.alternate_email,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText:'Email' ,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black)),
                ),
                onFieldSubmitted: (value){
                //FocusScope.of(context).requestFocus(passwordFocusNode)  ;
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              SizedBox(height: 20,),
              ValueListenableBuilder(valueListenable: _obsequrePassword,
                  builder:(context,value,child){
                return  TextFormField(
                  controller: _passwordController,
                  focusNode: passwordFocusNode,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.white,
                  obscureText: _obsequrePassword.value,
                  obscuringCharacter: '*',

                  decoration: InputDecoration(

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon( Icons.key,
                        )),
                    suffixIcon: InkWell(
                      onTap: (){
                        _obsequrePassword.value=!_obsequrePassword.value;
                      },
                        child: Icon(_obsequrePassword.value?Icons.visibility_off_outlined:
                        Icons.visibility)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),

                    labelText: 'Password',
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                );
                  }),
              SizedBox(height: height * .085,),
              RoundButton(title: 'Login',
                  loading: authViewModel.loading,
                  onPress: (){
              if(_emailController.text.isEmpty){
                Utils.flushbarErrorMessage('Enter email', context);

              }else if(_passwordController.text.isEmpty){
                Utils.flushbarErrorMessage('Enter password', context);

              }else if(_passwordController.text.length<8){
                Utils.flushbarErrorMessage('Enter atleast 8 characters', context);

              }else{
                Map data={
                  'email':_emailController.text.toString(),
                  'password':_passwordController.text.toString()
                };
                authViewModel.loginApi(data,context);
                print('Api hit');
              }
              }),
              SizedBox(height: height * .02,),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.signup);
                  },
                  child: Text("Don't have an account?Sign Up")),

            ]

          ),
        ),
      ),
    );
  }
}

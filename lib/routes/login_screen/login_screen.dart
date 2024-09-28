import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/app_text_input_fields.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});


  @override
  LoginScreenState createState () => LoginScreenState();
}


class LoginScreenState extends State<LoginScreen>{



  late final TextEditingController emailController;
  late final TextEditingController passwordController;


  final email = "admin@gmail.com";
  final password = "123456";


@override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }


  @override
  void dispose() {
    super.dispose();


    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90,),
                Center(
                  child:Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/logo.jpg"))
                  ),
                )),
                const SizedBox(height: 40,),
              const Text("Welcome to UPF Admin", style: AppStyles.bigBoldGreyTextStyle,),

              const SizedBox(height: 20,),
              DOutlinedTextInputField(
                hintText: "Email", 
                hintTextStyle: AppStyles.normalGreyTextStyle, 
                valueTextStyle: AppStyles.normalBlackTextStyle, 
                borderColor: Colors.grey, 
                borderRadius: 10, 
                btnHeight: 50, 
                keyboardType: TextInputType.emailAddress,
                controller: emailController),

              const SizedBox(height: 20,),
              DOutlinedTextInputField(
                hintText: "password", 
                hintTextStyle: AppStyles.normalGreyTextStyle, 
                valueTextStyle: AppStyles.normalBlackTextStyle, 
                borderColor: Colors.grey, 
                borderRadius: 10, 
                btnHeight: 50, 
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: passwordController),


              const SizedBox(height: 50,),
              DSolidButton(
                label: "CONTINUE", 
                btnHeight: 45, 
                bgColor: AppColors.primaryColor, 
                borderRadius: 10, 
                textStyle: AppStyles.normalWhiteTextStyle, 
                onClick: ()=> checkAndContinue(context))
              ],
            ),
          ), )),
    );
  }

  void checkAndContinue(BuildContext context){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      if(email== emailController.text.trim()){
        if(password == passwordController.text.trim()){
          Navigator.pushNamed(context, RouteGenerator.homeScreen);
        }else{
          Fluttertoast.showToast(msg: "Invalid password");
        }
      }else{
        Fluttertoast.showToast(msg: "Account with Email not found");
      }
    }else{
      Fluttertoast.showToast(msg: "Please fill in fields");
    }
  }
}
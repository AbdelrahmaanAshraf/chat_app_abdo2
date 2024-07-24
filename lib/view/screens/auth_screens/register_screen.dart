import 'package:chat_app_abdo2/model/cubit/auth/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app_abdo2/view/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../consts.dart';
import '../../../model/cubit/auth/sign_up_cubit/sign_up_state.dart';
import '../home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static String id ='RegisterScreen';

  @override
  Widget build(BuildContext context) {
    var singUpCubit = SignUpCubit.get(context);
    return BlocConsumer<SignUpCubit,SignUpState>(
      listener: (context, state){
        if (state is SuccessSignUPState){
          Fluttertoast.showToast(
              msg: "Success Sign up",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);
          //Navigate.pushAndReplacement(context, const HomeScreen());
          Navigator.pushNamed(context, HomeScreen.id,arguments: singUpCubit.sigUpEmailController.text);
        }else if(state is FailureSignUPState) {
          Fluttertoast.showToast(
              msg: singUpCubit.errorMessage!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Form(
              key: singUpCubit.signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontFamily: 'Pacifico',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleas enter your email';
                      } else {
                        return null;
                      }
                    },
                    controller: singUpCubit.sigUpEmailController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Email',
                        labelStyle:
                        TextStyle(color: Colors.white38, fontSize: 20.sp)),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleas enter your password';
                      } else {
                        return null;
                      }
                    },
                    controller: singUpCubit.sigUpPasswordController,
                    obscureText: singUpCubit.obscure,
                    obscuringCharacter: '*',
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              singUpCubit.showPassword();
                            },
                            icon: singUpCubit.obscure
                                ? const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            )
                                : const Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            )),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Password',
                        labelStyle:
                        TextStyle(color: Colors.white38, fontSize: 20.sp)),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () {
                      if (singUpCubit.signUpFormKey.currentState!.validate()){
                        singUpCubit.checkSignUp();
                      }
                    },
                    child: state is LoadingSignUPState
                        ? const CircularProgressIndicator()
                        : Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account",
                        style:
                        TextStyle(color: Colors.white54, fontSize: 14.sp),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context,const LoginScreen());
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.blueAccent),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}

import 'package:chat_app_abdo2/model/cubit/auth/login_cubit/login_cubit.dart';
import 'package:chat_app_abdo2/model/cubit/auth/login_cubit/login_state.dart';
import 'package:chat_app_abdo2/view/screens/auth_screens/register_screen.dart';
import 'package:chat_app_abdo2/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../consts.dart';
import '../../../services/navigation/navigate.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    var loginCubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          Fluttertoast.showToast(
              msg: "WELCOME!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);
          //Navigate.pushAndReplacement(context, const HomeScreen());
          Navigator.pushNamed(context, HomeScreen.id,
              arguments: loginCubit.emailController.text);
        } else if (state is FailureLoginState) {
          Fluttertoast.showToast(
              msg: loginCubit.errorMessage!,
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
          //resizeToAvoidBottomInset: false,
          backgroundColor: kPrimaryColor,
          body: Form(
            key: loginCubit.loginFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                        'Login',
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
                    controller: loginCubit.emailController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
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
                    controller: loginCubit.passwordController,
                    obscureText: loginCubit.obscure,
                    obscuringCharacter: '*',
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            loginCubit.showPassword();
                          },
                          icon: loginCubit.obscure
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                )),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: const OutlineInputBorder(),
                      errorBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(color: Colors.white38, fontSize: 20.sp),
                    ),
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
                      if (loginCubit.loginFormKey.currentState!.validate()) {
                        //loginCubit.loginFormKey.currentState?.save();
                        loginCubit.checkLogin();
                      }
                    },
                    child: state is LoadingLoginState
                        ? const CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't have an account",
                        style:
                            TextStyle(color: Colors.white54, fontSize: 14.sp),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigate.push(
                              context,
                              const RegisterScreen(),
                            );
                          },
                          child: Text(
                            'Sign UP',
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

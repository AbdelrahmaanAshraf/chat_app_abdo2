import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/local/shared_preference/shared_preference.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  String? errorMessage;

  void getUser({required String email, required String password}) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SuccessLoginState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'Email not found, please sign up first !';
        emit(
          FailureLoginState(errorMessage: errorMessage!),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password pleas try again !';
        print('Wrong password provided for that user.');
        emit(
          FailureLoginState(errorMessage: errorMessage!),
        );
      }
    }
  }

  var loginFormKey = GlobalKey<FormState>();

  void showPassword() {
    obscure = !obscure;
    emit(ShowPasswordState());
  }

  void checkLogin() {
    emit(LoadingLoginState());
    Future.delayed(
      const Duration(seconds: 1),
      () {
          getUser(
              email: emailController.text, password: passwordController.text);
          SharedPreference.set(SharedPreference.isLoginKey, true);
      },
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreference.set(SharedPreference.isLoginKey, false);
    emit(LogOutState());
  }
}

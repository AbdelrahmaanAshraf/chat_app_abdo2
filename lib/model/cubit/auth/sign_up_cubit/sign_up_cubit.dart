import 'package:chat_app_abdo2/model/cubit/auth/sign_up_cubit/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(InitSignUPState());

  static SignUpCubit get(context) => BlocProvider.of<SignUpCubit>(context);
  TextEditingController sigUpEmailController = TextEditingController();
  TextEditingController sigUpPasswordController = TextEditingController();
  bool obscure = true;
  String? errorMessage;

  void createUser({required String email, required String password}) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SuccessSignUPState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
        emit(
          FailureSignUPState(errorMessage: errorMessage!),
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email !';
        emit(
          FailureSignUPState(errorMessage: errorMessage!),
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  var signUpFormKey = GlobalKey<FormState>();

  void showPassword() {
    obscure = !obscure;
    emit(ShowPasswordState());
  }

  void checkSignUp() {
    emit(LoadingSignUPState());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        createUser(
            email: sigUpEmailController.text,
            password: sigUpPasswordController.text);
      },
    );
  }
}

abstract class LoginState {}

class InitLoginState extends LoginState {}

class SuccessLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class FailureLoginState extends LoginState {
  String errorMessage ;


  FailureLoginState({required this.errorMessage});
}

class LogOutState extends LoginState {}

class ShowPasswordState extends LoginState {}

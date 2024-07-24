abstract class SignUpState {}

class ShowPasswordState extends SignUpState {}

class InitSignUPState extends SignUpState {}

class SuccessSignUPState extends SignUpState {}

class LoadingSignUPState extends SignUpState {}

class FailureSignUPState extends SignUpState {

  String errorMessage ;


  FailureSignUPState({required this.errorMessage});
}

import 'package:bloc/bloc.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
  );

  final LoginNavigator navigator;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void updateLoginButtonState(String username, String password) {
    final isLoginEnabled = username.isNotEmpty && password.isNotEmpty;
    emit(_model.copyWith(isLoginEnabled: isLoginEnabled));
  }

  void showCircularProgressIndicator(bool isLoading)
  {
    emit(_model.copyWith(isLoading: isLoading));
  }





}

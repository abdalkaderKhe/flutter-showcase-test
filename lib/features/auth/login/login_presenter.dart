
import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
      LoginPresentationModel super.model,
      this.navigator,
      this.logInUseCase,
      );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;
  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;


  void userNameChange(String userName){
    _updateState(userName: userName);
  }

  void passwordChange(String password){
    _updateState(password: password);
  }

  Future<void> loginClick() async {
    emit(_model.copyWith(isLoadingEnabled: true));
    await await logInUseCase
        .execute(username: _model.userName, password: _model.password)
        .asyncFold(
          (fail) async => await navigator.showError(fail.displayableFailure()),
          (success) async => await navigator.showAlert(
              title: 'success',
              message: 'You have been logged in successfully',),
        );
    emit(_model.copyWith(isLoadingEnabled: false));
  }

  void _updateState({String? userName, String? password}) {
    emit(_model.copyWith(userName: userName, password: password));
    if (_isLoginEnabled()) {
      emit(_model.copyWith(isLoginEnabled: true));
    }
  }

  bool _isLoginEnabled() {
    return _model.userName.isNotEmpty && _model.password.isNotEmpty;
  }

}

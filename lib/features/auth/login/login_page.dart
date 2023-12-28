// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/domain/model/displayable_failure.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';
import 'package:flutter_demo/navigation/alert_dialog_route.dart';
import 'package:flutter_demo/navigation/error_dialog_route.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PresenterStateMixin<LoginViewModel,
    LoginPresenter, LoginPage> ,ErrorDialogRoute,AlertDialogRoute{
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => presenter.updateLoginButtonState(userNameController.text,passwordNameController.text),  //TODO
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordNameController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => presenter.updateLoginButtonState(userNameController.text,passwordNameController.text), //TODO
              ),
              const SizedBox(height: 16),

             stateObserver(
                builder: (context, state) =>
                state.isLoading
                    ?
                const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    if(state.isLoginEnabled)
                      {
                        presenter.showCircularProgressIndicator(true);
                        final reulte = await LogInUseCase(UserStore()).execute(username: userNameController.text, password: passwordNameController.text);
                        if(reulte.isRight())
                          {
                            presenter.showCircularProgressIndicator(false);
                            await showAlert(title: 'success', message: 'You have been logged in successfully');
                          }
                        else
                        {
                          presenter.showCircularProgressIndicator(false);
                          await showError(DisplayableFailure(title: ' Login Failure', message: const LogInFailure.unknown().toString()));
                        }
                      }
                    else
                    {
                      doNothing();
                    }
                  }, //TODO
                  child: Text(appLocalizations.logInAction),
                ),
              ),


            ],
          ),
        ),
      );
}

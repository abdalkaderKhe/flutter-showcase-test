import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
      // ignore: avoid_unused_constructor_parameters
      LoginInitialParams initialParams,
      );

  /// Used for the copyWith method
  LoginPresentationModel._(String? userName, String? password,bool? isLoginEnabled,bool? isLoadingEnabled,)
      : _userName = userName,
        _password = password,
        _isLoginEnabled = isLoginEnabled,
        _isLoadingEnabled = isLoadingEnabled;

  String? _userName;
  String? _password;
  bool? _isLoginEnabled;
  bool? _isLoadingEnabled;

  @override
  String get password => _password ?? '';

  @override
  String get userName => _userName ?? '';

  @override
  bool get isLoadingEnabled => _isLoadingEnabled?? false;

  @override
  bool get isLoginEnabled => _isLoginEnabled ?? false;

  LoginPresentationModel copyWith({String? userName, String? password,bool? isLoginEnabled,bool? isLoadingEnabled,}) {
    return LoginPresentationModel._(
      userName ?? this.userName,
      password ?? this.password,
      isLoginEnabled ?? this.isLoginEnabled,
      isLoadingEnabled ?? this.isLoadingEnabled,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  String get userName;
  String get password;
  bool get isLoginEnabled;
  bool get isLoadingEnabled;
}



import 'package:flutter_demo/features/auth/login/login_initial_params.dart';



/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ) : isLoginEnabled = false,
      isLoading = false;

  @override
  final bool isLoginEnabled;

  @override
  final bool isLoading;




  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.isLoginEnabled,
    required this.isLoading,
  });


  LoginPresentationModel copyWith({
    bool? isLoginEnabled,
    bool? isLoading,
    bool? loginIsFails,
    bool? loginIsSuccessfully,
  }) {
    return LoginPresentationModel._(
      isLoginEnabled: isLoginEnabled ?? this.isLoginEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }





}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
  bool get isLoading;
}



abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class LoginErrorState extends LoginStates {}

class ChangeRememberState extends LoginStates {}
class ChangePasswordVisibilityState extends LoginStates{}
part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Equatable {
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String msg;

  LoginSuccess(String s, {required this.msg});

  @override
  List<Object?> get props => [msg];
}

class LoginFailure extends LoginState {
  final String msg;

  LoginFailure(String string, {required this.msg});

  @override
  List<Object?> get props => [msg];
}

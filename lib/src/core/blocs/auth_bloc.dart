import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData{
  final String email;
  final String phone;
  UserData({required this.email, required this.phone});
}

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserData? data;

  const AuthenticationState(
      {this.status = AuthenticationStatus.unauthenticated, this.data});

  AuthenticationState copyWith(
      {AuthenticationStatus? status, UserData? data}) {
    return AuthenticationState(
        status: status ?? this.status,
        data: data??this.data);
  }

  @override
  List<Object?> get props => [status, data];
}

class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserDetails extends AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String email;
  final String phone;
  Login(this.email, this.phone);

  @override
  List<Object?> get props => [email, phone];
}

class LogOut extends AuthenticationEvent {}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc() : super(const AuthenticationState()) {
    on<LoadUserDetails>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try{
        final userData = UserData(email: prefs.getString("email")!, phone: prefs.getString('phone')!);
        emit(state.copyWith(status: AuthenticationStatus.authenticated, data: userData));
      }catch(e){
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
      }
    });
    on<Login>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', event.email);
      await prefs.setString('phone', event.phone);
      final userData = UserData(email: event.email, phone: event.phone);
      emit(state.copyWith(status: AuthenticationStatus.authenticated, data: userData));
    });
    on<LogOut>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      prefs.remove('phone');
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    });
  }
}
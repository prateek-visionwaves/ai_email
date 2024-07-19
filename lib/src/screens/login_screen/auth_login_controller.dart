import 'package:ai_email/src/core/blocs/auth_bloc.dart';
import 'package:ai_email/src/screens/home_screen/home_screen.dart';
import 'package:ai_email/src/screens/login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLoginController extends StatelessWidget {
  const AuthLoginController({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationBloc>().add(LoadUserDetails());
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state){
      if(state.status == AuthenticationStatus.authenticated){
        return const HomeScreen();

      }
      return const LoginScreen();
    });
  }
}

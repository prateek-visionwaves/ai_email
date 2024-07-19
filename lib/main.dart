import 'package:ai_email/src/app.dart';
import 'package:ai_email/src/core/blocs/auth_bloc.dart';
import 'package:ai_email/src/core/permissions/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionManager().requestMicrophonePermission();

  runApp(BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: const MyApp()));
}

import 'package:ai_email/src/core/api_service/api_service.dart';
import 'package:ai_email/src/core/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triton_extensions/triton_extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ApiService apiService = ApiService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: 24.padding,
          children: [
            Image.asset(
              'assets/VW_1152.png',
              height: 200,
            ),
            Center(
                child: Text(
              'Ai-Email',
              style: context.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
            Center(
              child: Text(
                'Welcome, Please login to continue',
                style: context.textTheme.titleMedium,
              ),
            ),
            16.space,
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        String pattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    16.space,
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(hintText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        String pattern = r'^\+?[0-9]{10,15}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    16.space,
                    !loading? FilledButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final data = {
                              "email" : emailController.text.trim(),
                              "secret" : phoneController.text.trim()
                            };
                            setState(() {
                              loading=true;
                            });
                            apiService.post('https://dev.visionwaves.com/emailagent/emailservice/validateUser', data).then((value) async {
                              setState(() {
                                loading=false;
                              });
                              if (value.data['result'] ?? false) {
                                context.read<AuthenticationBloc>().add(Login(emailController.text.trim(), phoneController.text.trim()));
                              }else{
                                context.showSnackBar(snackBar: const SnackBar(content: Text('Details not found')));
                              }
                            }).catchError((error){
                              setState(() {
                                loading=false;
                              });
                            });
                          }
                        },
                        child: const Text('Submit')):const CircularProgressIndicator()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

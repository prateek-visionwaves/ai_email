import 'dart:developer';
import 'package:ai_email/src/core/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.read<AuthenticationBloc>().state.data;
    final url = "https://www.oration.ai/playground/aramco?email_id=${data!.email}";
    log(url);
    final navigationDelegate = NavigationDelegate(
      onNavigationRequest: (req) async {
        log("Navigation ${req.url}");
        if (req.url.contains('http://') ||
            req.url.contains('https://') ||
            req.url.contains('file://')) {
          return NavigationDecision.navigate;
        } else {
          final uri = Uri.parse(req.url);
          await launchUrl(uri);
          return NavigationDecision.prevent;
        }
      },
    );

    final controller = WebViewController(
      onPermissionRequest: (request) async {
        log("Permission request ${request.toString()}");
        await Permission.microphone.request();
        request.grant();
      },
    );

    controller
      ..loadRequest(Uri.parse(url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(navigationDelegate);
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyIT'),
          actions: [
            IconButton(onPressed: (){
              context.read<AuthenticationBloc>().add(LogOut());
            }, icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
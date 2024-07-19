// import 'package:myit/logger/logger.dart';
// import 'package:myit/permissions/permission_manager.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// final logger = Logger('WebViewPermissionManager');
//
// class WebViewPermissionManager{
//
//   final PermissionManager _permissionManager = PermissionManager();
//
//   Future<void> requestPermission(WebViewPermissionRequest request) async {
//     logger.log(request.platform.types.first.name.toString());
//     switch(request.platform.types.first.name){
//       case 'microphone':{
//         if(await _permissionManager.isMicrophonePermissionGranted()){
//             request.grant();
//         }else{
//           if(await _permissionManager.requestMicrophonePermission()){
//             request.grant();
//           }else{
//             request.deny();
//           }
//         }
//       }
//       case 'camera':{
//         if(await _permissionManager.isCameraPermissionGranted()){
//           request.grant();
//         }else{
//           if(await _permissionManager.requestCameraPermission()){
//             request.grant();
//           }else{
//             request.deny();
//           }
//         }
//         break;
//       }
//       default: {
//         request.deny();
//         break;
//       }
//     }
//   }
// }
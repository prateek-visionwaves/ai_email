import 'package:ai_email/src/core/logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

final _logger = Logger('PermissionManager');

class PermissionManager {
  // Check and request microphone permission
  Future<bool> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    return _handlePermissionStatus(status);
  }

  // Check and request camera permission
  Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return _handlePermissionStatus(status);
  }

  // Check and request storage permission
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return _handlePermissionStatus(status);
  }

  // Check and request phone permission (for calls)
  Future<bool> requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();
    return _handlePermissionStatus(status);
  }

  // Check and request SMS permission
  Future<bool> requestSmsPermission() async {
    PermissionStatus status = await Permission.sms.request();
    return _handlePermissionStatus(status);
  }

  // Check and request call log permission
  Future<bool> requestCallLogPermission() async {
    PermissionStatus status = await Permission.phone.request();
    return _handlePermissionStatus(status);
  }

  // Check and request nearby devices permission
  Future<bool> requestNearbyDevicesPermission() async {
    PermissionStatus status = await Permission.bluetooth.request();
    return _handlePermissionStatus(status);
  }

  // Check and request location permission
  Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return _handlePermissionStatus(status);
  }

  // Check the current status of microphone permission
  Future<bool> isMicrophonePermissionGranted() async {
    PermissionStatus status = await Permission.microphone.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of camera permission
  Future<bool> isCameraPermissionGranted() async {
    PermissionStatus status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of storage permission
  Future<bool> isStoragePermissionGranted() async {
    PermissionStatus status = await Permission.storage.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of phone permission (for calls)
  Future<bool> isPhonePermissionGranted() async {
    PermissionStatus status = await Permission.phone.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of SMS permission
  Future<bool> isSmsPermissionGranted() async {
    PermissionStatus status = await Permission.sms.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of call log permission
  Future<bool> isCallLogPermissionGranted() async {
    PermissionStatus status = await Permission.phone.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of nearby devices permission
  Future<bool> isNearbyDevicesPermissionGranted() async {
    PermissionStatus status = await Permission.bluetooth.status;
    return status == PermissionStatus.granted;
  }

  // Check the current status of location permission
  Future<bool> isLocationPermissionGranted() async {
    PermissionStatus status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  // Handle permission status
  bool _handlePermissionStatus(PermissionStatus status) {
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _logger.log('Permission denied. Show a message to the user.');
    } else if (status.isPermanentlyDenied) {
      _logger.log('Permission permanently denied. Open app settings.');
      openSettings();
    }
    return false;
  }

  // Open app settings
  Future<void> openSettings() async {
    final isOpen = await openAppSettings();
    if (!isOpen) {
      _logger.log('Failed to open settings');
    }
  }

  Future<void> requestPermissionByName(String name) async {
    _logger.log(name);
    switch(name){
      case 'microphone':{
        await Permission.microphone.request();
      }
      case 'camera':{
        await Permission.camera.request();
      }
      case 'nearby-devices':{
        await Permission.nearbyWifiDevices.request();
      }
      default: {
        break;
      }
    }
  }
}

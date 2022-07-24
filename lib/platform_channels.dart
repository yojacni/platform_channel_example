import 'package:flutter/services.dart';

class PlatformChannels {
  static const methodChannelName =
      "com.example.platform_channels_example/sendsms";
  final MethodChannel methodChannel = const MethodChannel(methodChannelName);
  late UtilsMethod utils;

  PlatformChannels() {
    utils = UtilsMethod(methodChannel: methodChannel);
  }
}

class ChannelMethod {
  final MethodChannel methodChannel;

  ChannelMethod({required this.methodChannel});
}

class UtilsMethod extends ChannelMethod {
  static const sendSmsMethodName = "utils:send-sms";

  UtilsMethod({required MethodChannel methodChannel})
      : super(methodChannel: methodChannel);

  Future<T> sendSms<T>() async {
    return await methodChannel.invokeMethod(sendSmsMethodName, []);
  }
}

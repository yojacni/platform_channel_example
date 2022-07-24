import Foundation

class PlatformChannelController{
  static let channelName= "com.example.platform_channels_example/sendsms";

  unowned let viewController: FlutterViewController
  let channel: FlutterMethodChannel

  init(viewController: FlutterViewController){
    self.viewController = viewController
    self.channel = FlutterMethodChannel(name: PlatformChannelController.channelName, binaryMessenger: 
    viewController as! FlutterBinaryMessenger
    )
  }
  
  func setupChannel () {
    channel.setMethodCallHandler{ (call, result) in 
    switch call.method {
    case "utils:send-sms":
      let alert= UIAlertController(title: "Mensaje", message: "Hola", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
      self.viewController.present(alert, animated: true, completion: nil)
      break;
    default:
      break;  
    }
    }
  }

}
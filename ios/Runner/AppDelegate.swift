import Flutter
import UIKit
import MessageUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    guard let viewController = window?.rootViewController as? FlutterViewController else {
          fatalError("Invalid view controller")
    }
    let platformChannelController = FlutterMethodChannel(name: "com.example.platform_channels_example/sendsms", binaryMessenger: viewController as! FlutterBinaryMessenger)
    
    platformChannelController.setMethodCallHandler{ (call, result) in
    switch call.method {
    case "utils:send-sms":
      let string = "Este es un texto de ejemplo"
        if (MFMessageComposeViewController.canSendText()) {
            self.result?("Success")
            let controller = MFMessageComposeViewController()
            controller.body = string.htmlToString
            controller.recipients = recipent
            controller.messageComposeDelegate = self
            UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
        } else {
            self.result?("Message service is not available")
        }
      break;
    default:
      break;
    }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//MARK: MFMessageComposeViewControllerDelegate
extension SwiftFlutterSocialContentSharePlugin:MFMessageComposeViewControllerDelegate{
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        let map: [MessageComposeResult: String] = [
            MessageComposeResult.sent: "sent",
            MessageComposeResult.cancelled: "cancelled",
            MessageComposeResult.failed: "failed",
        ]
        if let callback = self.result {
            callback(map[result])
        }
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}


//MARK: MFMailComposeViewControllerDelegate
extension SwiftFlutterSocialContentSharePlugin: MFMailComposeViewControllerDelegate{
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

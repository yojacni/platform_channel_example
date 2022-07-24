import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    guard let viewController = window?.rootViewController as? FlutterViewController else {
          fatalError("Invalid view controller")
    }
    let platformChannelController = PlatformChannelController(viewController: viewController)
    platformChannelController.setupChannel()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

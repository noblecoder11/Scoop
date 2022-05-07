import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
     application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  //Screenshot prohibition code
    override func applicationWillResignActive(
       application: UIApplication
    ) {
      self.window.isHidden = true;
    }
    override func applicationDidBecomeActive(
      _ application: UIApplication
    ) {
      self.window.isHidden = false;
    }
}
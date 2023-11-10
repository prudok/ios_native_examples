import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(
      name: "samples.ios.examples/battery", binaryMessenger: controller.binaryMessenger)
    weak var registrar = self.registrar(forPlugin: "plugin-name")

    let factory = FLNativeViewFactory(messenger: registrar!.messenger())

    self.registrar(forPlugin: "<plugin-name>")!.register(
      factory,
      withId: "<platform-view-type>")

    batteryChannel.setMethodCallHandler {
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "getBatteryLevel" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.receiveBatteryLevel(result: result)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(
        FlutterError(
          code: "UNAVAILABLE",
          message: "Battery level not available.",
          details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }
}

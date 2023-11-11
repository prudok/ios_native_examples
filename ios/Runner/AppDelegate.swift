import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "samples.ios.examples", binaryMessenger: controller.binaryMessenger)
        weak var registrar = self.registrar(forPlugin: "none")
        
        let factory = FLNativeViewFactory(messenger: registrar!.messenger())
        
        self.registrar(forPlugin: "none1")!.register(
            factory,
            withId: "<platform-view-type>")
        
        channel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "getBatteryLevel":
                self.receiveBatteryLevel(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
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

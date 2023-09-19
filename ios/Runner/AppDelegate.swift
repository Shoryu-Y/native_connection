import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        setMethodChannel()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func setMethodChannel() {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(
            name: "dev.shoryu.native_connection",
            binaryMessenger: controller.binaryMessenger
        )
        methodChannel.setMethodCallHandler {[weak self] call, result in
            switch call.method {
            case "getBatteryLevel":
                self?.getBatteryLevel(result: result)
            case "getSimpleString":
                result("SimpleString")
            case "getSimpleInt":
                result(0)
            case "getSimpleBool":
                let arg = call.arguments as? Bool ?? false
                result(arg)
            case "getSimpleList":
                let list = [0, 1, 2]
                result(list)
            case "getSimpleMap":
                let dictionary = ["zero": 0, "one": 1, "two": 2]
                result(dictionary)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func getBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(
            FlutterError(
                code: "UNAVAILABLE",
                message: "Battery level not available.",
                details: nil
            )
        )
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
}

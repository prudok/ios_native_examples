import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return FLNativeView(
      frame: frame,
      viewIdentifier: viewId,
      arguments: args,
      binaryMessenger: messenger)
  }

  public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

class FLNativeView: NSObject, FlutterPlatformView {
  private var customView: UIView

  init(
    frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?,
    binaryMessenger messenger: FlutterBinaryMessenger?
  ) {
    customView = UIView()
    super.init()
    createNativeView(view: customView)
  }

  func view() -> UIView {
    return customView
  }

  func createNativeView(view customView: UIView) {
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    let nativeLabel = UILabel()

    customView.backgroundColor = UIColor.white
    nativeLabel.text = "Native text from iOS"
    nativeLabel.textColor = UIColor.blue
    nativeLabel.textAlignment = .center
    nativeLabel.frame = CGRect(
      x: 0, y: screenHeight / 2, width: screenWidth,
      height: 50.0
    )
    customView.addSubview(nativeLabel)
  }
}

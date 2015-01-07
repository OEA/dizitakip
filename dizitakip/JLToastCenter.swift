import UIKit

@objc public class JLToastCenter: NSObject {
    
    private var _queue: NSOperationQueue!
    
    private struct Singletone {
        static let defaultCenter = JLToastCenter()
    }
    
    public class func defaultCenter() -> JLToastCenter {
        return Singletone.defaultCenter
    }
    
    override init() {
        super.init()
        self._queue = NSOperationQueue()
        self._queue.maxConcurrentOperationCount = 1
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "deviceOrientationDidChange:",
            name: UIDeviceOrientationDidChangeNotification,
            object: nil
        )
    }
    
    public func addToast(toast: JLToast) {
        self._queue.addOperation(toast)
    }
    
    func deviceOrientationDidChange(sender: AnyObject?) {
        if self._queue.operations.count > 0 {
            let lastToast: JLToast = _queue.operations[0] as JLToast
            lastToast.view.updateView()
        }
    }
}
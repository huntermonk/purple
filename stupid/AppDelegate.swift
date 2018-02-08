import Firebase
import Mixpanel
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func applicationDidFinishLaunching(_ application: UIApplication) {
        application.isIdleTimerDisabled = true
        FirebaseApp.configure()
        Mixpanel.sharedInstance(withToken: "adac3b2ae091933e0168a8d332386163")
    }
}

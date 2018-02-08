import Firebase
import Mixpanel
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.isIdleTimerDisabled = true
        FirebaseApp.configure()
        Mixpanel.sharedInstance(withToken: "adac3b2ae091933e0168a8d332386163")
        return true
    }
}

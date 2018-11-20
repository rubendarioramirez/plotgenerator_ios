

import Foundation

import UIKit
import NVActivityIndicatorView
import GoogleMobileAds


var activityIndicator : NVActivityIndicatorView! //used variable for intialising object for NVActivityIndicatorView
var customAppColor = UIColor(red: 57.0/255.0, green: 149.0/255.0, blue: 111.0/255.0, alpha: 1)




extension UIViewController:NVActivityIndicatorViewable,GADBannerViewDelegate {
    
  /*  func adsView(adsBannerView:GADBannerView){
        adsBannerView.adUnitID=bannerAdUnit
        adsBannerView.delegate = self
        adsBannerView.rootViewController=self
        adsBannerView.load(GADRequest())
        self.view.bringSubview(toFront: adsBannerView)
    }
    
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        //adBannerView.isHidden = false
        print("yes i am loaded")
        
        NotificationCenter.default.post(name: Notification.Name("isloaded"), object: nil)
    }
    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("yes i am not loaded")
        // adBannerView.isHidden = true
    }*/
    
    //Show screen Loader while loading data on screen
    func showactivityIndicator() {
        _ = CGSize(width:50, height: 50)
      //  startAnimating(size, message: "", messageFont: UIFont.systemFont(ofSize: 18), type: NVActivityIndicatorType.circleStrokeSpin, color: customAppColor, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), textColor: .black)
        
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let frame = CGRect(x: (xAxis - 30), y: (yAxis - 30), width: 45, height: 45)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = .circleStrokeSpin
        activityIndicator.color = customAppColor
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
    }
    
    //hide screen loader when screen data loading is completed
    func hideactivityIndicator()
    {
        //stopAnimating()
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
       
    }
    
    //push the controller to next screen
    func pushController(indentifier:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: indentifier)
        if indentifier != ""{
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    //pop the controller to previous screen
    func popController()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func respondToHomeSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                //  self.navigationController?.popToRootViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
            case UISwipeGestureRecognizerDirection.down: break
            //  print("Swiped down")
            case UISwipeGestureRecognizerDirection.left: break
            // print("Swiped left")
            case UISwipeGestureRecognizerDirection.up: break
            // print("Swiped up")
            default:
                break
            }
        }
    }
    
    
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension Array{
    
    func random()->Int{
        return Int(arc4random_uniform(UInt32(self.count)))
    }
}


//Change image color
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

//Check for device or detect screen size of devices
extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
}


//
//  AppDelegate.swift
//  Plot story assistant
//
//  Created by webastral on 11/1/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import UIKit
import SWRevealViewController
import IQKeyboardManagerSwift
import Firebase
import GoogleMobileAds


var sideMenu = SWRevealViewController()
let rewardAdUnit = "ca-app-pub-6696437403163667/5553168332"
let interstitialAdUnit = "ca-app-pub-6696437403163667/5389516806"
let bannerAdUnit = "ca-app-pub-6696437403163667/7609868923"
let appDel = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,GADRewardBasedVideoAdDelegate{

    var window: UIWindow?
    var rewardBasedVideo: GADRewardBasedVideoAd?
    var adRequestInProgress = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GADMobileAds.configure(withApplicationID: "ca-app-pub-6696437403163667~6953226633")
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo?.delegate = self
        loadRewardAds()
        
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        silentLogin()
        
        
        return true
    }
    @objc func loadRewardAds() {

        if !adRequestInProgress && rewardBasedVideo?.isReady == false {
            
            rewardBasedVideo?.load(GADRequest(),
                                   withAdUnitID: rewardAdUnit)
            adRequestInProgress = true
        }
        
    }

    // MARK: GADRewardBasedVideoAdDelegate implementation
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        adRequestInProgress = false
        print("Reward based video ad failed to load: \(error.localizedDescription)")
        loadRewardAds()
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        adRequestInProgress = false
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
        
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        loadRewardAds()
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
        
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        NotificationCenter.default.post(name: Notification.Name("rewardAD"), object: nil, userInfo: nil)
    }
    
    func silentLogin(){
        let story = UIStoryboard(name: "Main", bundle: nil)
        
                    var frontVC:AnyObject?
                    frontVC = ViewController()
                    frontVC = story.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
                    let frontNav = UINavigationController(rootViewController: frontVC as! UIViewController)
                    frontNav.isNavigationBarHidden = true
                    var rearNav:AnyObject?
                    rearNav = UINavigationController(rootViewController: story.instantiateViewController(withIdentifier: "SideBarVC"))
        
                    let revealController = SWRevealViewController(rearViewController: rearNav as! UIViewController!, frontViewController: frontNav)
        
                    sideMenu = revealController!
                    window?.rootViewController = sideMenu
                    window?.makeKeyAndVisible()
                    UIApplication.shared.isStatusBarHidden = true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


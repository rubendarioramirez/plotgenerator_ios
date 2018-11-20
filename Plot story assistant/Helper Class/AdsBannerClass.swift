//
//  AdsBannerClass.swift
//  Plot story assistant
//
//  Created by webastral on 11/20/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds


protocol AdsBannerDelegate {
    func isloaded(isTrue:Bool)
}

protocol interstitialBannerDelegate{
    func isDismiss(isTrue:Bool)
}

class AdBannerView : NSObject,GADBannerViewDelegate,GADInterstitialDelegate{
    
    var objDelegate : AdsBannerDelegate?
    var objInterstitialDelegate : interstitialBannerDelegate?
    var interstitial: GADInterstitial!
    
    static func shared() -> AdBannerView {
        struct Static {
            static let manager = AdBannerView()
        }
        return Static.manager
    }
    
    func adsView(adsBannerView:GADBannerView,topview:UIViewController){
        adsBannerView.adUnitID=bannerAdUnit
        adsBannerView.delegate = self
        adsBannerView.rootViewController=topview
        adsBannerView.load(GADRequest())
        topview.view.bringSubview(toFront: adsBannerView)
    }
    
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        objDelegate?.isloaded(isTrue: true)
    }
    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("yes i am not loaded")
        objDelegate?.isloaded(isTrue: false)
        // adBannerView.isHidden = true
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID:interstitialAdUnit)
        interstitial.delegate = self
        GADRequest().testDevices = [kGADSimulatorID]
        interstitial.load(GADRequest())
        return interstitial
    }
    
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("i am call now")
    }
    
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        objInterstitialDelegate?.isDismiss(isTrue: true)
    }
    
}

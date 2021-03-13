//
//  IntersitialAd.swift
//  Lato
//
//  Created by juandahurt on 7/03/21.
//

import GoogleMobileAds
import UIKit


final class Interstitial: NSObject, GADInterstitialDelegate {
    static private let testIntersitialID = "ca-app-pub-3940256099942544/1033173712"
    static private let interstitialID = "ca-app-pub-3880886608489890/9105515396"
    var interstitial: GADInterstitial = GADInterstitial(adUnitID: interstitialID)
    
    override init() {
        super.init()
        loadInterstitial()
    }
    
    func loadInterstitial() {
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd() {
        if self.interstitial.isReady {
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
}

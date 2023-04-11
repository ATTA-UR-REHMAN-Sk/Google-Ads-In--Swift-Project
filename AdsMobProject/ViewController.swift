//
//  ViewController.swift
//  AdsMobProject
//
//  Created by apple on 30/03/2023.
//
// APP ID: ca-app-pub-4939521595837648~3668687586
// unit ID: ca-app-pub-4939521595837648/4612149887
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADFullScreenContentDelegate {

   // override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private var interstitial: GADInterstitialAd?
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        loadIntAd()
        
    }

    @IBAction func btnChk2Ad(_ sender: UIButton) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
        
        
    }
    
    func loadIntAd() {
        
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
        
    }
    
    func ViewDidReciveAd(_ bannerView: GADInterstitialAd){
        print("received ad")
    }
    
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
        loadIntAd()
    }

}

extension ViewController : GADBannerViewDelegate {
    
    func adViewDidReciveAd(_ bannerView: GADBannerView){
        print("received ad")
    }
//
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWitherror error: GADErrorCode) {
        print(error)
    }
}

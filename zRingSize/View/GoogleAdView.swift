//
//  GoogleAdView.swift
//  zRingSize
//
//  Created by zero_ALL on 5/4/24.
//

import SwiftUI
import GoogleMobileAds

struct GoogleAdView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewController()
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let banner = GADBannerView(adSize: bannerSize)
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        banner.adUnitID = "ca-app-pub-6342983620525776/7065190857"
        banner.load(GADRequest())
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

//
//  GoogleAdView.swift
//  zRingSize
//
//  Created by zero_ALL on 5/4/24.
//

import SwiftUI
import GoogleMobileAds

struct GoogleAdView: View {
    @Binding var adLoaded: Bool
    
    var body: some View {
        ZStack {
            if adLoaded {
                BannerViewController(adLoaded: $adLoaded)
                    .frame(height: 50)  // 광고의 높이에 맞게 조정하세요
            } else {
                Text("이 위치는 광고입니다")
                    .frame(height: 50)  // 광고의 높이와 동일하게 설정
                    .background(Color.gray.opacity(0.2))
            }
        }
    }
}

struct BannerViewController: UIViewControllerRepresentable {
    @Binding var adLoaded: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let banner = GADBannerView(adSize: bannerSize)
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        banner.adUnitID = "ca-app-pub-6342983620525776/7065190857"
//        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716" // 테스트
        banner.load(GADRequest())
        banner.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        var parent: BannerViewController
        
        init(_ parent: BannerViewController) {
            self.parent = parent
        }
        
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("bannerViewDidReceiveAd")
            DispatchQueue.main.async {
                self.parent.adLoaded = true
            }
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.parent.adLoaded = false
            }
        }
        
        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("bannerViewDidRecordImpression")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillDIsmissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}

// Preview 제공자
struct GoogleAdView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAdView(adLoaded: .constant(false))
    }
}

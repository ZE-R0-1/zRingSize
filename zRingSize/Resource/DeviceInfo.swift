//
//  DeviceInfo.swift
//  zRingSize
//
//  Created by KMUSER on 2024/05/02.
//

import Foundation

struct DeviceInfo {
    let nativeWidth: CGFloat
    let nativeHeight: CGFloat
    let screenSize: CGFloat
    
    static let allDevices: [DeviceInfo] = [
        DeviceInfo(nativeWidth: 320, nativeHeight: 480, screenSize: 3.5),
        DeviceInfo(nativeWidth: 640, nativeHeight: 960, screenSize: 3.5),
        DeviceInfo(nativeWidth: 640, nativeHeight: 1136, screenSize: 4),
        DeviceInfo(nativeWidth: 750, nativeHeight: 1334, screenSize: 4.7),
        DeviceInfo(nativeWidth: 1080, nativeHeight: 2340, screenSize: 5.4),
        DeviceInfo(nativeWidth: 1242, nativeHeight: 2208, screenSize: 5.5),
        DeviceInfo(nativeWidth: 1125, nativeHeight: 2436, screenSize: 5.8),
        DeviceInfo(nativeWidth: 828, nativeHeight: 1792, screenSize: 6.1),
        DeviceInfo(nativeWidth: 1170, nativeHeight: 2532, screenSize: 6.1),
        DeviceInfo(nativeWidth: 1179, nativeHeight: 2556, screenSize: 6.1),
        DeviceInfo(nativeWidth: 1242, nativeHeight: 2688, screenSize: 6.5),
        DeviceInfo(nativeWidth: 1284, nativeHeight: 2778, screenSize: 6.7),
        DeviceInfo(nativeWidth: 1290, nativeHeight: 2796, screenSize: 6.7)
    ]
    
    static func screenSize(forWidth width: CGFloat, height: CGFloat) -> CGFloat? {
        if let device = allDevices.first(where: { $0.nativeWidth == width && $0.nativeHeight == height }) {
            return device.screenSize
        }
        return nil
    }
}

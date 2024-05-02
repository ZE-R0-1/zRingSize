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
        DeviceInfo(nativeWidth: 1242, nativeHeight: 2208, screenSize: 5.5)
    ]
    
    static func screenSize(forWidth width: CGFloat, height: CGFloat) -> CGFloat? {
        if let device = allDevices.first(where: { $0.nativeWidth == width && $0.nativeHeight == height }) {
            return device.screenSize
        }
        return nil
    }
}

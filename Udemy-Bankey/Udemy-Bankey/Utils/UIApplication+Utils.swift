//
//  UIApplication+Utils.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-25.
//

import UIKit

extension UIApplication {
    static var statusBarSize: CGSize {
        let zeroSize = CGSize(width: 0, height: 0)
        if #available(iOS 13.0, *) {
            if #available(iOS 15.0, *) {
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                return window?.windowScene?.statusBarManager?.statusBarFrame.size ?? zeroSize
            } else {
                let window = shared.windows.filter { $0.isKeyWindow }.first
                return window?.windowScene?.statusBarManager?.statusBarFrame.size ?? zeroSize
            }
        } else {
            return shared.statusBarFrame.size
        }
    }
}

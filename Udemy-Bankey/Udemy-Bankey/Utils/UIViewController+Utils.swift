//
//  UIViewController+Utils.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-25.
//

import UIKit

extension UIViewController {
//    func setStatusBar() {
//        let statusBarSize = UIApplication.statusBarSize
//        let frame = CGRect(origin: .zero, size: statusBarSize)
//        let statusBarView = UIView(frame: frame)
//
//        statusBarView.backgroundColor = appColor
//        view.addSubview(statusBarView)
//    }
    
    func setStatusBar() {
           let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
           navBarAppearance.backgroundColor = appColor
           UINavigationBar.appearance().standardAppearance = navBarAppearance
           UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
       }

    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

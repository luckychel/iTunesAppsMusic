//
//  UIViewController+Extensions.swift
//  iOSArchitecturesDemo
//
//  Created by Александр Кукоба on 14.04.2023.
//

import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            return self.navigationController?.navigationBar.frame.height ?? 0.0
        }
    }
}

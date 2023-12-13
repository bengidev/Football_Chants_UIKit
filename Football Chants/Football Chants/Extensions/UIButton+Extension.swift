//
//  UIButton+Extension.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import UIKit

extension UIButton {
    func setAppStyle() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.tintColor = .white
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 15.0
        self.titleEdgeInsets.right = -10
        self.imageEdgeInsets.left = -10
    }
}

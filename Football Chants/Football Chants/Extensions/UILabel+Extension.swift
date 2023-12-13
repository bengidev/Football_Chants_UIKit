//
//  UILabel+Extension.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import UIKit

extension UILabel {
    func applyAppStyle() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.textAlignment = .center
        self.textColor = .black
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
    }
}

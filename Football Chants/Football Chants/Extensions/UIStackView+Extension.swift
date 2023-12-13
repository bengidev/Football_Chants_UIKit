//
//  UIStackView+Extension.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import UIKit

extension UIStackView {
    func applyAppStyle() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.spacing = 8.0
    }
}

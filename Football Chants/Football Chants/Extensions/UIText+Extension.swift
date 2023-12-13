//
//  UIText+Extension.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import UIKit

extension UITextView {
    func applyAppStyle() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.textAlignment = .center
        self.textColor = .black
        self.textContainerInset = .init(
            top: 10.0,
            left: 10.0,
            bottom: 10.0,
            right: 10.0
        )
    }
}

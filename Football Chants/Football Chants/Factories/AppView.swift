//
//  AppView.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 14/12/23.
//

import UIKit

final class AppView: NSObject {
    private override init() {
        super.init()
    }
    
    class func buildView() -> UIView {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return vw
    }
    
    class func buildButton() -> UIButton {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bt.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.tintColor = .white
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 15.0
        bt.titleEdgeInsets.right = -10
        bt.imageEdgeInsets.left = -10
        
        return bt
    }
    
    class func buildLabel() -> UILabel {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.textAlignment = .center
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.adjustsFontSizeToFitWidth = true
        
        return lb
    }
    
    class func buildTextView() -> UITextView {
        let vw = UITextView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.textAlignment = .center
        vw.textColor = .black
        vw.textContainerInset = .init(
            top: 10.0,
            left: 10.0,
            bottom: 10.0,
            right: 10.0
        )
        
        return vw
    }
    
    class func buildStackView() -> UIStackView {
        let vw = UIStackView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.spacing = 8.0
        
        return vw
    }
    
    class func buildTableView() -> UITableView {
        let vw = UITableView(frame: .zero, style: .plain)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.allowsSelection = true
        vw.separatorStyle = .none
        vw.rowHeight = UITableView.automaticDimension
        vw.estimatedRowHeight = 44.0
        
        return vw
    }
}



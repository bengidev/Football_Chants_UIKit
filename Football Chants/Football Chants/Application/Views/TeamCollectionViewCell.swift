//
//  TeamCollectionViewCell.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 12/12/23.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "TeamCollectionViewCellIdentifier"
    
    private lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    func changeNameLabel(to value: String) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.nameLabel.text = value
            self.contentView.layoutIfNeeded()
        }
    }
    
    private func setupView() -> Void {
        self.addSubview(self.nameLabel)
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
}

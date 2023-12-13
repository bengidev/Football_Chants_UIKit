//
//  TeamTableViewCell.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class TeamTableViewCell: UITableViewCell {
    static let cellIdentifier = "TeamTableViewCellIdentifier"

    private lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.text = "tester"
        
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        self.contentView.addSubview(self.nameLabel)
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(10.0)
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct TeamTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(TeamTableViewCell())
            .previewLayout(.sizeThatFits)
    }
}
#endif

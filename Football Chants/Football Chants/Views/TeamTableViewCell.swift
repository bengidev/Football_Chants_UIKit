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
    
    var cellBackgroundColor: UIColor = .red
    
    private lazy var baseStackView: UIStackView = {
        let vw = AppView.buildStackView()
        vw.axis = .vertical
        vw.backgroundColor = .clear
        
        return vw
    }()
    
    private lazy var containerStackView: UIStackView = {
        let vw = AppView.buildStackView()
        vw.axis = .vertical
        vw.layer.cornerRadius = 10.0
        vw.clipsToBounds = true
        vw.backgroundColor = self.cellBackgroundColor
        
        return vw
    }()
    
    private lazy var hOneStackView: UIStackView = {
        let vw = AppView.buildStackView()
        vw.axis = .horizontal
        vw.backgroundColor = .clear
        
        return vw
    }()

    private lazy var vOneStackView: UIStackView = {
        let vw = AppView.buildStackView()
        vw.axis = .vertical
        vw.alignment = .leading
        vw.backgroundColor = .clear
        
        return vw
    }()
    
    private lazy var teamBadgeView: UIImageView = {
        let vw = AppView.imageView()
        vw.image = .init(resource: .manchesterUnitedIc)
        
        return vw
    }()

    private lazy var teamNameLabel: UILabel = {
        let lb = AppView.buildLabel()
        lb.text = "Manchester United"
        lb.font = .preferredFont(forTextStyle: .title2).rounded().bold()
        
        return lb
    }()

    private lazy var teamFoundedLabel: UILabel = {
        let lb = AppView.buildLabel()
        lb.text = "Founded: 1878"
        lb.textColor = .label.withAlphaComponent(0.7)
        lb.font = .preferredFont(forTextStyle: .body).italic()
        
        return lb
    }()
    
    private lazy var teamLeaderLabel: UILabel = {
        let lb = AppView.buildLabel()
        lb.text = "Current Manager: Erik ten Hag"
        lb.textColor = .label.withAlphaComponent(0.7)
        lb.font = .preferredFont(forTextStyle: .body).italic()
        
        return lb
    }()
    
    private lazy var teamInfoTextView: UITextView = {
        let vw = AppView.buildTextView()
        vw.isScrollEnabled = false
        vw.backgroundColor = .clear
        vw.font = .preferredFont(forTextStyle: .footnote)
        vw.text = "Manchester United Football Club, commonly referred to as Man United (often stylised as Man Utd), or simply United, is a professional football club based in Old Trafford, Greater Manchester, England. The club competes in the Premier League, the top division in the English football league system. Nicknamed the Red Devils, they were founded as Newton Heath LYR Football Club in 1878, but changed their name to Manchester United in 1902. After a spell playing in Clayton, Manchester, the club moved to their current stadium, Old Trafford, in 1910."
        
        return vw
    }()

    private lazy var playButton: UIButton = {
        let bt = AppView.buildImageButton()
        bt.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        bt.setImage(.init(systemName: "play.circle.fill"), for: .normal)
        bt.tintColor = .white
        bt.backgroundColor = .clear
        bt.setPreferredSymbolConfiguration(
            .init(font: .preferredFont(forTextStyle: .title1), scale: .large), 
            forImageIn: .normal
        )
        
        return bt
    }()
    
    private lazy var cellSeparatorView: UIView = {
        let vw = AppView.buildView()
        vw.backgroundColor = .clear
        
        return vw
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    @objc
    func playButtonTapped(_ sender: UIButton) -> Void {
        print("Play Button was tapped!")
    }
    
    private func setupViews() -> Void {
        self.contentView.addSubview(self.baseStackView)
        
        self.baseStackView.addArrangedSubview(self.containerStackView)
        self.baseStackView.addArrangedSubview(self.cellSeparatorView)
        self.baseStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerStackView.addArrangedSubview(self.hOneStackView)
        self.containerStackView.setCustomSpacing(10.0, after: self.hOneStackView)
        
        self.hOneStackView.addArrangedSubview(self.vOneStackView)
        self.hOneStackView.addArrangedSubview(self.playButton)
        
        self.vOneStackView.addArrangedSubview(self.teamBadgeView)
        self.vOneStackView.setCustomSpacing(20.0, after: self.teamBadgeView)
        
        self.vOneStackView.addArrangedSubview(self.teamNameLabel)
        self.vOneStackView.setCustomSpacing(10.0, after: self.teamNameLabel)
        
        self.vOneStackView.addArrangedSubview(self.teamFoundedLabel)
        self.vOneStackView.addArrangedSubview(self.teamLeaderLabel)
        self.vOneStackView.setCustomSpacing(10.0, after: self.teamLeaderLabel)
        
        self.vOneStackView.addArrangedSubview(self.teamInfoTextView)

        self.teamBadgeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.0)
            make.leading.equalToSuperview().inset(10.0)
            make.width.height.equalTo(50.0)
        }
        
        self.teamNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
        }
        
        self.teamFoundedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
        }
        
        self.teamLeaderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
        }
        
        self.teamInfoTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        self.playButton.snp.makeConstraints { make in
            make.width.equalTo(50.0)
        }
        
        self.cellSeparatorView.snp.makeConstraints { make in
            make.height.equalTo(10.0)
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

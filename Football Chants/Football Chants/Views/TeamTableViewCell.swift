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
    
    var didTapPlayChantButton: (() -> Void)? = {}
    var didTapInformationButton: (() -> Void)? = {}
    
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
        
        return vw
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let lb = AppView.buildLabel()
        lb.font = .preferredFont(forTextStyle: .title2).rounded().bold()
        
        return lb
    }()
    
    private lazy var teamFoundedLabel: UILabel = {
        let lb = AppView.buildLabel()
        lb.textColor = .label.withAlphaComponent(0.7)
        lb.font = .preferredFont(forTextStyle: .body).italic()
        
        return lb
    }()
    
    private lazy var teamLeaderLabel: UILabel = {
        let lb = AppView.buildLabel()
        lb.textColor = .label.withAlphaComponent(0.7)
        lb.font = .preferredFont(forTextStyle: .body).italic()
        
        return lb
    }()
    
    private lazy var teamInfoTextView: UITextView = {
        let vw = AppView.buildTextView()
        vw.isScrollEnabled = false
        vw.backgroundColor = .clear
        vw.font = .preferredFont(forTextStyle: .footnote)
        
        return vw
    }()
    
    private lazy var playButton: UIButton = {
        let bt = AppView.buildImageButton()
        bt.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        bt.tintColor = .white
        bt.backgroundColor = .clear
        bt.setPreferredSymbolConfiguration(
            .init(font: .preferredFont(forTextStyle: .title1), scale: .large),
            forImageIn: .normal
        )
        
        return bt
    }()
    
    private lazy var informationButton: UIButton = {
        let bt = AppView.buildImageTextButton()
        bt.addTarget(self, action: #selector(self.informationButtonTapped(_:)), for: .touchUpInside)
        bt.tintColor = .white
        bt.backgroundColor = .clear
        bt.titleLabel?.font = .preferredFont(forTextStyle: .footnote).bold()
        bt.setPreferredSymbolConfiguration(
            .init(font: .preferredFont(forTextStyle: .footnote), scale: .default),
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
    
    func updateCellViews(with team: Team) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.containerStackView.backgroundColor = team.teamType.background
            self.teamBadgeView.image = team.teamType.badge
            self.teamNameLabel.text = team.name
            self.teamFoundedLabel.text = "Founded: \(team.founded)"
            self.teamLeaderLabel.text = "Current \(team.teamLeader.job.rawValue): \(team.teamLeader.name)"
            self.teamInfoTextView.text = team.info
            self.teamInfoTextView.isHidden = !team.isShowingInformation
            self.playButton.setImage(
                .init(systemName: team.isPlayingChant ? "pause.circle.fill" : "play.circle.fill"),
                for: .normal
            )
            self.informationButton.setTitle(
                team.isShowingInformation ? "Hide Information" : "Show Information",
                for: .normal
            )
            self.informationButton.setImage(
                .init(systemName: team.isShowingInformation ? "chevron.up" : "chevron.down"),
                for: .normal
            )

            self.setNeedsLayout()
        }
    }
    
    func configureCellBackgroundColor(_ color: UIColor) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.containerStackView.backgroundColor = color
            self.setNeedsLayout()
        }
    }

    private func setupViews() -> Void {
        self.contentView.isUserInteractionEnabled = true
        self.contentView.addSubview(self.baseStackView)
        
        self.baseStackView.addArrangedSubview(self.containerStackView)
        self.baseStackView.addArrangedSubview(self.cellSeparatorView)
        self.baseStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerStackView.addArrangedSubview(self.hOneStackView)
        self.containerStackView.setCustomSpacing(10.0, after: self.hOneStackView)
        
        self.containerStackView.addArrangedSubview(self.informationButton)
        self.informationButton.snp.makeConstraints { make in
            make.height.equalTo(44.0)
        }
        
        self.hOneStackView.addArrangedSubview(self.vOneStackView)
        self.hOneStackView.addArrangedSubview(self.playButton)
        
        self.vOneStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        self.vOneStackView.addArrangedSubview(self.teamBadgeView)
        self.vOneStackView.setCustomSpacing(20.0, after: self.teamBadgeView)
        self.teamBadgeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.0)
            make.leading.equalToSuperview().inset(10.0)
            make.width.height.equalTo(50.0)
        }
        
        self.vOneStackView.addArrangedSubview(self.teamNameLabel)
        self.vOneStackView.setCustomSpacing(10.0, after: self.teamNameLabel)
        self.teamNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
        }
        
        self.vOneStackView.addArrangedSubview(self.teamFoundedLabel)
        self.teamFoundedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
        }
        
        self.vOneStackView.addArrangedSubview(self.teamLeaderLabel)
        self.vOneStackView.setCustomSpacing(10.0, after: self.teamLeaderLabel)
        self.teamLeaderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.0)
        }
        
        self.vOneStackView.addArrangedSubview(self.teamInfoTextView)
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
    
    @objc
    private func playButtonTapped(_ sender: UIButton) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.didTapPlayChantButton?()
            self.layoutIfNeeded()
        }
    }
    
    @objc
    private func informationButtonTapped(_ sender: UIButton) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.didTapInformationButton?()
            self.layoutIfNeeded()
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

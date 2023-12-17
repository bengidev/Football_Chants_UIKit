//
//  TeamView.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class TeamView: UIView {
    private var viewModel: TeamViewModel?
    private var containerColor: UIColor = .lightGray
    
    private lazy var backgroundView: UIView = {
        let vw = AppView.buildView()
        vw.backgroundColor = containerColor
        
        return vw
    }()
    
    private lazy var containerView: UIView = {
        let vw = AppView.buildView()
        vw.backgroundColor = self.containerColor
        
        
        return vw
    }()
    
    private lazy var tableView: UITableView = {
        let vw = AppView.buildTableView()
        vw.showsVerticalScrollIndicator = false
        vw.backgroundColor = self.containerColor
        vw.delegate = self
        vw.dataSource = self
        vw.register(
            TeamTableViewCell.self,
            forCellReuseIdentifier: TeamTableViewCell.cellIdentifier
        )
        
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    func configureViewModel(_ viewModel: TeamViewModel) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.viewModel = viewModel
        }
    }
    
    private func setupViews() -> Void {
        self.setupLongPressGesture()
        
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.containerView)
        self.backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerView.addSubview(self.tableView)
        self.containerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10.0)
        }
    }
    
    private func setupLongPressGesture() -> Void {
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.handleLongPressGesture(_:))
        )
        self.tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc
    private func handleLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        self.changeCellBackgroundInTouch(sender)
    }
    
    private func changeCellBackgroundInTouch(_ sender: UILongPressGestureRecognizer) -> Void {
        let teams: [Team] = self.viewModel?.teams ?? []
        let touchPoint = sender.location(in: self.tableView)
        
        sender.minimumPressDuration = 0.2
        if sender.state == .began {
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
                
                let badgeColor = teams[indexPath.row].teamType.background.withAlphaComponent(0.5)
                cell.configureCellBackgroundColor(badgeColor)
                
                print("Long Press Began at: \(indexPath)")
            }
        } else if sender.state == .ended {
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
                
                let badgeColor = teams[indexPath.row].teamType.background
                cell.configureCellBackgroundColor(badgeColor)
                
                print("Long Press Ended at: \(indexPath)")
            }
        }
    }
}

extension TeamView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel?.teams.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellIdentifier, for: indexPath) as? TeamTableViewCell else { return .init() }
        var teams: [Team] = self.viewModel?.teams ?? []
        
        // Configure the cell...
        
        cell.selectionStyle = .none
        cell.updateCellViews(with: teams[indexPath.row])
        
        cell.didTapPlayChantButton = { [weak self] in
            self?.viewModel?.playChant(for: teams[indexPath.row])
            tableView.reloadData()
        }
        
        cell.didTapInformationButton = { [weak self] in
            teams[indexPath.row].toggleIsShowingInformation()
            cell.updateCellViews(with: teams[indexPath.row])
            
            self?.refreshTableView()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lb = UILabel()
        lb.text = "English Premier League"
        lb.font = .preferredFont(forTextStyle: .title3).bold()
        
        return lb
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        
        self.refreshTableView()
    }
    
    private func refreshTableView() -> Void {
        self.tableView.beginUpdates()
        self.tableView.setNeedsLayout()
        self.tableView.endUpdates()
    }
    
}

#if DEBUG
@available(iOS 13, *)
struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(TeamView())
            .previewLayout(.sizeThatFits)
    }
}
#endif

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
    private var teams: [Team] = []
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
    
    func configureTeamData(_ teams: [Team]) -> Void {
        UIView.animate(withDuration: 1.0) {
            self.teams = teams
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
        let touchPoint = sender.location(in: self.tableView)
        
        sender.minimumPressDuration = 0.2
        if sender.state == .began {
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
                
                let badgeColor = self.teams[indexPath.row].teamType.background.withAlphaComponent(0.5)
                cell.configureCellBackgroundColor(badgeColor)
                
                print("Long Press Began at: \(indexPath)")
            }
        } else if sender.state == .ended {
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
                
                let badgeColor = self.teams[indexPath.row].teamType.background
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
        return self.teams.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellIdentifier, for: indexPath) as? TeamTableViewCell else { return .init() }
        
        // Configure the cell...
        
        cell.selectionStyle = .none
        cell.configureTeamCellViews(self.teams[indexPath.row])
        cell.layoutIfNeeded()
        
        cell.didTapPlayChantButton = {
            tableView.performBatchUpdates {
                self.teams[indexPath.row].toggleIsPlayingChant()
                cell.configureTeamCellViews(self.teams[indexPath.row])
                cell.layoutIfNeeded()
            }
        }
        
        cell.didTapInformationButton = {
            tableView.performBatchUpdates {
                self.teams[indexPath.row].toggleIsShowingInformation()
                cell.configureTeamCellViews(self.teams[indexPath.row])
                cell.layoutIfNeeded()
            }
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
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
        
        tableView.performBatchUpdates {
            cell.configureCellBackgroundColor(self.teams[indexPath.row].teamType.background.withAlphaComponent(0.5))
            
            DispatchQueue.main.async {
                cell.configureCellBackgroundColor(self.teams[indexPath.row].teamType.background)
            }
            
            cell.configureTeamCellViews(self.teams[indexPath.row])
            cell.layoutIfNeeded()
        }
        
        print("Tapped Index: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.layoutIfNeeded()
    }
    
    /*
     // Override to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
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

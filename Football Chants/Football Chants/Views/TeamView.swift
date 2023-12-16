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
    
    @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: self.tableView)
        
        if sender.state == .began {
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // your code here, get the row for the indexPath or do whatever you want
                print("Longpress Began at: \(indexPath)")
                
                guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
                cell.cellBackgroundColor = .yellow

                print("Longpress Began at: \(indexPath)")
                
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        } else if sender.state == .ended {
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // your code here, get the row for the indexPath or do whatever you want
                print("Longpress Ended at: \(indexPath)")
                
                guard let cell = tableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
                cell.cellBackgroundColor = .blue

                print("Longpress Ended at: \(indexPath)")
                
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    private func setupViews() -> Void {
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
            action: #selector(self.handleLongPress)
        )
        self.tableView.addGestureRecognizer(longPressRecognizer)
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
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellIdentifier, for: indexPath) as? TeamTableViewCell else { return .init() }
        
        // Configure the cell...
        
        cell.selectionStyle = .none
        
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
        cell.cellBackgroundColor = .blue
        
        tableView.reloadRows(at: [indexPath], with: .automatic)

        print("Tapped Index: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
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

//
//  TeamView.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 13/12/23.
//

import SwiftUI
import UIKit

final class TeamView: UIView {
    private lazy var tableViewContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return vw
    }()
    
    private lazy var tableView: UITableView = {
        let vw = UITableView(frame: .zero, style: .plain)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.allowsSelection = true
        vw.separatorStyle = .none
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
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() -> Void {
        self.backgroundColor = .red
        
        self.addSubview(self.tableViewContainer)
        self.tableViewContainer.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableViewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tableViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.tableView.widthAnchor.constraint(equalTo: self.tableViewContainer.widthAnchor),
            self.tableView.heightAnchor.constraint(equalTo: self.tableViewContainer.heightAnchor),
        ])
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
        
        cell.changeNameLabel(to: "Team Number: \(indexPath.row)")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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


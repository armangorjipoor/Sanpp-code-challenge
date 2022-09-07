//
//  Missions_VC+Extension.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/17/1401 AP.
//

import Foundation
import UIKit

extension Missions_VC: UITableViewDataSource, UITableViewDelegate {
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: "MissionsTableVCell", bundle: nil), forCellReuseIdentifier: "MissionCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MissionCell", for: indexPath) as? MissionsTableVCell else { return UITableViewCell() }
        cell.nameLbl.text = dataModel[indexPath.row].name
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
}
